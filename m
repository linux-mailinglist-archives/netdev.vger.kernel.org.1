Return-Path: <netdev+bounces-182732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4173EA89C83
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B72B44481A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BE92951AF;
	Tue, 15 Apr 2025 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="NlPSse7u"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2F29293B;
	Tue, 15 Apr 2025 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716574; cv=none; b=bBKG+N+vLUbLH3lR5V0ZrqLWfOGZoAc00pXIpCm4/55WjQomfI2lIr1tgdUPWOmjasYn5dtTs/ReI2JlAhEEGTkN0GarhxJ1E/BmIZfwflxB8fOIKRO49iujpJydIvHPyQ75m5gyfOUBQpzN51ug+Yd4rV2HQNInVqyf67iyKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716574; c=relaxed/simple;
	bh=/VJqlNcmuF/omtdMrqp7LLuvHl1sqV176vgL+HZQrdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSZE7YJeUFWfsBpDozap5UiwpwTnaUJ5oE27rtegEahqTgb2OCy52PU+v2E0PA6RZZVM2Z+nomGrdWf+fcI7uIANc3mBnalQLR4wqpdDo4PH9aBqpA0JCzm5Y5BfkQIExefn1fprzrT5pS/YnSfUOGP0rWwo1mJVvisQD/pRmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=NlPSse7u; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744716570; x=1745321370; i=ps.report@gmx.net;
	bh=/VJqlNcmuF/omtdMrqp7LLuvHl1sqV176vgL+HZQrdw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NlPSse7u1hIVU54BVIW854djfK17D9W2UQqa9Smf1gCtN0rwHzdVPx3edkP1xiUl
	 qlxHcowl0WJhNhsccW70fSEv/Dg5dsFlgVF/6WeW/Ohg7H2/gjvCRPq9xDVFdTER7
	 Lm5iFJvXxGEMKlvYW/bcMPGsx9VEB8xvKBp4WJVrxElGxZspZ6+QyHfxgC1SkX5BW
	 CDXX3e6drgVeMjdtj5IOadDQdIFuEUgqyj9Z31rNWzHVNRyr1xAWrr0bSl5DcWkHE
	 QHx/OCcMFZ0SOM1NWLnW+8WuLOrUYFKMogzxQM9LCOHa9GFEvBTt0RNEnr6bONA3F
	 LLfNj/hwAKi70XhdrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VDE-1sy2AF3mUE-00rTSu; Tue, 15
 Apr 2025 13:29:29 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v2 0/3] net: pktgen: fix checkpatch code style errors/warnings
Date: Tue, 15 Apr 2025 13:29:13 +0200
Message-ID: <20250415112916.113455-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:q8Ww3fYfZ+j9JekUbpgZbApZekAhf3Mu7hN0ngSCVE5YXZIYlga
 k/UKBg2I87w7oFJIUNiCK8W6FMALa8vW5u4o/13TBzQjtupDs9W/K71BiZJRpPxfI50RU/J
 xPyhVr4Yj+nY/PGD2KEqnd+8LkrZkGBKYFATvlKmg/Eqxh2gWfRIpOZNipfKyJSEL/2F4jL
 z9j81WHOGm789jN0txg9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tMOzcAu5ZPA=;8kx5LLBKSVM2WautaLW27NQND3j
 C2XbntElnGwB790U0uMIilpJoRSHL9Hs4IMzI0xu40usMdrSy40e/EEGVrI4j0mUvcyX6j5mg
 +Od0UkXmn5veWXBApob/8OMUy4eREKxBI0qEm/39DXonuLiJFdQBRPphdarLgLOd2bI20dqWg
 9lRM8DYwbqLpm76QEUvF06fgjvQfj7nzngQ1wPHe9QPbvBAvMiQ3wuB5DTDQfbbwv4oI0vXrt
 EvsvvyFdxustlDDgFENuy/lfdy90BNXYN/HJAQK/BfPPmTt4AVI+o458a7/CnSWiMOPcGTTgK
 hmyjptfdluowHJ8R4uKukV0ksWmGos4I1ItZyOxy/IJ1VeZe1nYjqSDPUUfIleICkHfljqUf4
 CqZGBbNTmD7QHvXUSV0g3JM0SL4uJBOV4aK9rgrE8p1UFukpEJv5afBteseNFH7IYTjDFcuS+
 sI35aVXzj5r3ctCIDGfVaraD44J2ZEwFID4bnWv03XnlLG2XHrJp9KqVnadIFtFBcQrSx04QX
 q1We94frxy0XeyJYKEwyH20Kh4qemD1zJe2ZIkHr96n0dSl/Ji9KQO2XVV8V7Y2PwOWvCKA9M
 x2/n7/nNaGctWbOzxAQGmb+63rUrcMLZdzpOCfikL9T5aToowG/kRcW9GjNu/ir3iJDNzVBy3
 kPqf7XuwNZvrv1lGkTbaZTOW5b8sQL1oX8FFejJ6ftWMR+fnwX4EmeBuXNdgYXZFsCn1GdtOg
 aIVOVWjBD8ajYv9R/NQerT3R5YJ+nML5iWxXY2mZfvVbqyaTZoVipgpFXJXmNzIA+wappPhWx
 71bu8rlUo7hK6XIN+JMh9wbD0Nf7rsdGkKhPIZJZOtFf3Hruuuir6LA6VkaH6SJXvpZ2pcvKH
 A4g2ARQv4Gmyp4db9aef8n84BJ1Do8TMFqItRnV7Phh80KO1OwSwvNE4p3/oN1/R4V6cIdBmr
 2KyG9D+DU7c6Ve8YFISsO6fOlZYFlafdsmYLtlXYQhjOM/lktzILl/pd9MpF4IPNsS0viuJ+M
 +vrAGcuTWrw5BByK6T3c1QqNGsASDNwuypArgTcXNL+S9qbBK4QQCgg+RfDQMiqkg4ZzjEn38
 5PyZ0Iz8mABsi8sDCZD5WoEGwFJNdQBw89RiM681UWkM44NgarAmoWWma8MKT6hY6QBgPebqE
 LehEvRWOHGP8eLBEbIXyTxegtADIq2lmNTNF7ZfKd1n2uC716Ypbnu3+F2ncyhxvQqQBYFFGs
 9AMgEIw8PrezeU0n/A6/Kyuu2ZVyz4YQ634GHiHG47YmOKG5nh0Oj0s8FPfblswv8JWwhDx+g
 B2obuLHMocG5P+K1ytvrJ7fO3AbkYsFzdX0HrOURcSI/cOaDimvssxVZQwFzx0Bd9nrI4ncEp
 CRfBVl/r6woeKnfM2mOR5XwXYWlCYnQTPAG3ofuka5YRxzW1nn6lEY9xO2224U0nSd/vtUTGP
 VO5qSAq7qtZL4fsEh4uninkNklXg=

Rml4IGNoZWNrcGF0Y2ggZGV0ZWN0ZWQgY29kZSBzdHlsZSBlcnJvcnMvd2FybmluZ3MgZGV0ZWN0
ZWQgaW4KdGhlIGZpbGUgbmV0L2NvcmUvcGt0Z2VuLmMgKHJlbWFpbmluZyBjaGVja3BhdGNoIGNo
ZWNrcyB3aWxsIGJlIGFkZHJlc3NlZAppbiBhIGZvbGxvdyB1cCBwYXRjaCBzZXQpLgoKQ2hhbmdl
cyB2MSAtPiB2MjoKICAtIGRyb3AgYWxyZWFkeSBhcHBsaWVkIHBhdGNoZXMKICAtIHVwZGF0ZSAi
bmV0OiBwa3RnZW46IGZpeCBjb2RlIHN0eWxlIChFUlJPUjogZWxzZSBzaG91bGQgZm9sbG93IGNs
b3NlIGJyYWNlCiAgICAnfScpIgogICAgQWRkaXRpb25hbCBhZGQgYnJhY2VzIGFyb3VuZCB0aGUg
ZWxzZSBzdGF0ZW1lbnQgKGFzIHN1Z2dlc3RlZCBieSBhIGZvbGxvdwogICAgdXAgY2hlY2twYXRj
aCBydW4gYW5kIGJ5IEpha3ViIEtpY2luc2tpIGZyb20gY29kZSByZXZpZXcpLgogIC0gdXBkYXRl
ICJuZXQ6IHBrdGdlbjogZml4IGNvZGUgc3R5bGUgKFdBUk5JTkc6IHBsZWFzZSwgbm8gc3BhY2Ug
YmVmb3JlIHRhYnMpIgogICAgQ2hhbmdlIGZyb20gc3BhY2VzIHRvIHRhYiBmb3IgaW5kZW50IChz
dWdnZXN0ZWQgYnkgSmFrdWIgS2ljaW5za2kpLgogIC0gdXBkYXRlICJuZXQ6IHBrdGdlbjogZml4
IGNvZGUgc3R5bGUgKFdBUk5JTkc6IFByZWZlciBzdHJzY3B5IG92ZXIgc3RyY3B5KSIKICAgIFNx
dWFzaCBtZW1zZXQvc3Ryc2NweSBwYXR0ZXJuIGludG8gc2luZ2xlIHN0cnNjcHlfcGFkIGNhbGwg
KHN1Z2dlc3RlZAogICAgYnkgSmFrdWIgS2ljaW5za2kpLgogIC0gZHJvcCAibmV0OiBwa3RnZW46
IGZpeCBjb2RlIHN0eWxlIChXQVJOSU5HOiBicmFjZXMge30gYXJlIG5vdCBuZWNlc3NhcnkgZm9y
CiAgICBzaW5nbGUgc3RhdGVtZW50IGJsb2NrcykiIChzdWdnZXN0ZCBieSBKYWt1YiBLaWNpbnNr
aSkKClBldGVyIFNlaWRlcmVyICgzKToKICBuZXQ6IHBrdGdlbjogZml4IGNvZGUgc3R5bGUgKEVS
Uk9SOiBlbHNlIHNob3VsZCBmb2xsb3cgY2xvc2UgYnJhY2UKICAgICd9JykKICBuZXQ6IHBrdGdl
bjogZml4IGNvZGUgc3R5bGUgKFdBUk5JTkc6IHBsZWFzZSwgbm8gc3BhY2UgYmVmb3JlIHRhYnMp
CiAgbmV0OiBwa3RnZW46IGZpeCBjb2RlIHN0eWxlIChXQVJOSU5HOiBQcmVmZXIgc3Ryc2NweSBv
dmVyIHN0cmNweSkKCiBuZXQvY29yZS9wa3RnZW4uYyB8IDI0ICsrKysrKysrKystLS0tLS0tLS0t
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoK
LS0gCjIuNDkuMAoK

