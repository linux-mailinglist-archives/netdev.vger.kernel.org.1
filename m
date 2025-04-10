Return-Path: <netdev+bounces-181101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D92A83AEE
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5315D3AE2A4
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776F220C02C;
	Thu, 10 Apr 2025 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="jMLBxMdE"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E4D202998;
	Thu, 10 Apr 2025 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269489; cv=none; b=Lmi9XIjpqjGJs9rkQFr2jdyZ/drMSnTvPSJALQIvtUCb5bXQrbJByeJWkyd/nz2LCdWan1wlfemp5jLKej/CKU8sLbuh1qYupD8Kk+avlehhHzsNSamKGg291ljqMquIXp5zHy4LT/w2sRhRHQEWJASp0ZdkjRvtMqOlWmqSO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269489; c=relaxed/simple;
	bh=iWQwzw8zUtJit+AwgsL8NOa4zDpqs9YIi74TSagOxOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AcCjlHkpSJG1uK/tXFuYMloJzTLCZD2S+EasOpT497/Xuo5t56t1Zit/oyz28sxnnvs0M02XctSemgn9hju4Nr3f2kC+FdkkRkevS68B8YMHR2FLo6gC089jLMIHDQ8ltLNDP9op4bt17JeLL7QK6YrvymKZGRv/N0mvj111zSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=jMLBxMdE; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744269481; x=1744874281; i=ps.report@gmx.net;
	bh=iWQwzw8zUtJit+AwgsL8NOa4zDpqs9YIi74TSagOxOY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jMLBxMdEpkqZwWtAzmG9bZEoz0FRdQtBDsK19ahd4COaiyBkA/9NoA/0y8CuyPns
	 /JE2BC25DUVSTlrBuP78DWBjGVd0jbyJQ4UK+Kjgidnak8PKZli9EulZgFc2bgWip
	 CTmZ7J4hd1Z7ZFjLEowaW0MauDN1PkjJisqZ9Yn0VOr5QCmzIT480EFDW1V0iflwx
	 YvEmWolLRslB1Fi+bd35WlvKdhcHuQwoDY5w3+cPTBahdiD+N8OSW/k3IxjuwFOfZ
	 YcscyB6Maf2nUqaGAfbbvluFPfWAsmIX2bufuH2bQ7rHYAGwcNt2662wm8ZbnzB96
	 VpLXK0UR3YtsSeWazw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.74]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3DM-1trjXt0uUK-00FfVa; Thu, 10
 Apr 2025 09:18:01 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v1 00/11] net: pktgen: fix checkpatch code style errors/warnings
Date: Thu, 10 Apr 2025 09:17:37 +0200
Message-ID: <20250410071749.30505-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:IAhdy9rJRk599ntBBZtXjl21R5nGrwv3Hn2Epk6ajgpsOt6TrI2
 a+fch3567tXCohR7S4qD8TtqGtgPffzyUCc+iUf5mCNkBfvWjHPjO4EUHG39398a+15sJgH
 R7mVsVmc3oglUhDcdHxmgCqEqw7l8QcpqeK0A2j2VOVIYYiOy4Vpm5LBOBKE67mNCbPRgir
 ADkIuMhXYAqxtNasGy67A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GiHaxvR1eow=;ECBGzDW24PIEEo/O1DNwVETgdjY
 yQ09WuEXdYwEzv/2b+ruu4PbLvchXQhuF9c8f4Vm6UPfZabTnpgLLekBnqGk4xJoVsToSlZqB
 5iSAJ/9P8iuHuUxEKVIVHDLRXBALQR7QQh11L7AgrrXl7mnY2b913jtjFfZxY/Dg/6U5++2vl
 Syp99Jrl6EOjL/KnPCMLFDFpkg561uihb8Qenz1azC5DlOHL2jfyMEI6KiUAuBo83P/QMM8MV
 md12VKe87RMCHSOWpNmOgC2RpjRtq7MwwVEqdAKhnxq9e1NlLaAYjHzN5029hFunoWwBkLhtS
 FWHErmYRl2lMagNYvCLq1bvujpzrx65j9IXe6/1+rDutrCI+RfECUQuabiPUm1LQHoY65Vf9w
 MGwGMfm2hqAcrfwpaeC9mwyS1rlFJ8QCyGbvJOXLBHm1sCkEAF1gnAsmgGzEraIyPtBXsPa8e
 Nh1SPvLaj8GtFDW1g0gTmp/YtbVIHJ/GrVXMzjtOziQxjhPm2ckH0VXKBSGJPfS9JeDTPvN6Y
 yvLeC2cM5x9CTvsQ5HqlFJQexTBkfFocUV1t5hzD7/qknAawdpGMgyJg8aHtnPFtigVR4QWz2
 1M6IpGkxVfaVHQ/IaPqOOqy80731RQsRN1Mj+Mrr9UnLoIcmzL+O7qUTdkzIISUKKMOXbcJlt
 /8Lo/zmk/ay2aFzjXwZQBLfWOCsh8FdPyfBqcLKAkTJfknVTZdCUMmPFw448/zpFhCURUNTDG
 /1sllxuGibGexVng+e56lB3bPR4mOJllgMCcxIv7mqzPYuwHNw27GSzAYDCNhZ8RncC78IRcR
 8lgSTRAMeap8p6shntk1J8z9jPcVrDow2TFMXhxyPzg0uaCECi5dUXJZsmXfu8UJcBBtHRb6P
 ib9Q0MlZAY8vYR8MfDSj1HPu1VM9YEy7s98AvpkmRrD0L0nICu50YfiapjwcqqRwi3XkKAn0L
 M/DH/k+jAFGxDM1O1AO4tfpDL+Gevf0b22PpyVCkGZnqde6KrQnu9SVZfMd2xI1SPe/nh78Fd
 KwQHD8NOGP2yAYMQJ3LkdHJZ5yAE9J0xL4xYH1VZdXpYNig3LGp45cXLGACRDgO3Hq2Wlrrsu
 B0r5fwzOsFaXNovbWKKADiSRkFhywy6rlVxbJIanqw+FQPd2pv1A40DMiESkNX5PCSqIBn+ga
 Mz3ds/Tog24pxHv8xNPRxdhOMBgxh013B2l2K/6oELi4qy3H2ZHJSoHPLH54xt7gSmkPWhGQ3
 1zS0IYdllYtR2RNuOwv77DIM9tok2jTScEFmX26+F1IinXJxD1I3w6TB9S6w0HSrP7jxrpUyQ
 w63XAdA4SfQRHowPsoF5IoBnYjap3v4rFpCI8hqIYdBMHpQTt9byKSewkGyiCcz4f/hJTZA40
 AfxY84NsvB7XPqHfyu/AMOVt5STIMkxXlwafGjpuXp46LqJ3JE0zgaTKZ3HufurhtfcwRpLjf
 Z9twUF5vbwIMjXic3JGHrsCxY/4I=

Rml4IGNoZWNrcGF0Y2ggZGV0ZWN0ZWQgY29kZSBzdHlsZSBlcnJvcnMvd2FybmluZ3MgZGV0ZWN0
ZWQgaW4KdGhlIGZpbGUgbmV0L2NvcmUvcGt0Z2VuLmMgKHJlbWFpbmluZyBjaGVja3BhdGNoIGNo
ZWNrcyB3aWxsIGJlIGFkZHJlc3NlZAppbiBhIGZvbGxvdyB1cCBwYXRjaCBzZXQpLgoKUGV0ZXIg
U2VpZGVyZXIgKDExKToKICBuZXQ6IHBrdGdlbjogZml4IGNvZGUgc3R5bGUgKEVSUk9SOiAiZm9v
ICogYmFyIiBzaG91bGQgYmUgImZvbyAqYmFyIikKICBuZXQ6IHBrdGdlbjogZml4IGNvZGUgc3R5
bGUgKEVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGFmdGVyIHRoYXQgJyYnKQogIG5ldDogcGt0Z2Vu
OiBmaXggY29kZSBzdHlsZSAoRVJST1I6IGVsc2Ugc2hvdWxkIGZvbGxvdyBjbG9zZSBicmFjZQog
ICAgJ30nKQogIG5ldDogcGt0Z2VuOiBmaXggY29kZSBzdHlsZSAoV0FSTklORzogcGxlYXNlLCBu
byBzcGFjZSBiZWZvcmUgdGFicykKICBuZXQ6IHBrdGdlbjogZml4IGNvZGUgc3R5bGUgKFdBUk5J
Tkc6IHN1c3BlY3QgY29kZSBpbmRlbnQgZm9yCiAgICBjb25kaXRpb25hbCBzdGF0ZW1lbnRzKQog
IG5ldDogcGt0Z2VuOiBmaXggY29kZSBzdHlsZSAoV0FSTklORzogQmxvY2sgY29tbWVudHMpCiAg
bmV0OiBwa3RnZW46IGZpeCBjb2RlIHN0eWxlIChXQVJOSU5HOiBNaXNzaW5nIGEgYmxhbmsgbGlu
ZSBhZnRlcgogICAgZGVjbGFyYXRpb25zKQogIG5ldDogcGt0Z2VuOiBmaXggY29kZSBzdHlsZSAo
V0FSTklORzogbWFjcm9zIHNob3VsZCBub3QgdXNlIGEgdHJhaWxpbmcKICAgIHNlbWljb2xvbikK
ICBuZXQ6IHBrdGdlbjogZml4IGNvZGUgc3R5bGUgKFdBUk5JTkc6IGJyYWNlcyB7fSBhcmUgbm90
IG5lY2Vzc2FyeSBmb3IKICAgIHNpbmdsZSBzdGF0ZW1lbnQgYmxvY2tzKQogIG5ldDogcGt0Z2Vu
OiBmaXggY29kZSBzdHlsZSAoV0FSTklORzogcXVvdGVkIHN0cmluZyBzcGxpdCBhY3Jvc3MKICAg
IGxpbmVzKQogIG5ldDogcGt0Z2VuOiBmaXggY29kZSBzdHlsZSAoV0FSTklORzogUHJlZmVyIHN0
cnNjcHkgb3ZlciBzdHJjcHkpCgogbmV0L2NvcmUvcGt0Z2VuLmMgfCAxMTEgKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDY0IGlu
c2VydGlvbnMoKyksIDQ3IGRlbGV0aW9ucygtKQoKLS0gCjIuNDkuMAoK

