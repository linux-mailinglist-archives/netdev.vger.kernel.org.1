Return-Path: <netdev+bounces-83672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F5689349A
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 19:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBCA1F213F1
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A3615F414;
	Sun, 31 Mar 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eh3CqDiO"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258E15EFD3;
	Sun, 31 Mar 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903430; cv=fail; b=NvQQgOsk4q2nWCBs/OfwhaXCNsMmS6hZskSV4Q1kIPv682Oyvvx7IHzq3Y4RLyJYfaGU8KVir26V7NBNfJsJNFhuFYmsFoaPfhc8XlGNPT+rua40sVYITtzAfSo8xbVjZdDhpHghZm7VAE3WR5v5zYtwqJOrt3mX5iOtJg2rOK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903430; c=relaxed/simple;
	bh=h2e0Rk1GwFH61nYqZKTaPB5OUXZB/GVf7oszCINZEHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIQoGHhjx9WiL/lVfPzWXxkuraswd6QZLlNccm0dJjVBRbOJQHKxQGm2/33l55Ut13FM4Ijm4IbfWAozI3TIIQDvZas3Gq6nTVdbO1HsGpJ4HuvuxPMp3dgBhvYWdez2PWA1QUYx75Q8lxf8Mdx6UHS2E5a6aoz8G29mQZFvOIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=paul-moore.com; spf=fail smtp.mailfrom=paul-moore.com; dkim=fail (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eh3CqDiO reason="signature verification failed"; arc=none smtp.client-ip=209.85.128.171; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=paul-moore.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 89829208D8;
	Sun, 31 Mar 2024 18:43:45 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xXHGbshhfLwb; Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 79BC4208CC;
	Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 79BC4208CC
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 6D1F4800061;
	Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:44 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:40 +0000
X-sender: <netdev+bounces-83463-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAQUemlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 11215
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83463-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com DDBC9200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eh3CqDiO"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711747073; cv=none; b=IEFpzL+j6s4ROoZ9m+WmRtsDbZPWvRPaAOlVul1gnl+922OJOoBjb/HuCJ3iwPEDK1mF78WeWA2yuFgsFHBrCRseNrUIdkld7b6M1n5XUBTydlOahTDDwsLfuL7ySFyoJqk9bIJUeJ23RDhu4gE9DfMFDCA3hZRkhoyIXuxxLsQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711747073; c=relaxed/simple;
	bh=qXxP9z1f9YIuDyEcTXldM/7w/7mNjSwV0ZwC3PgLpPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZ+pad2noemRe/01E+nppjp0MEObj20OFHLBqEFQEGbrVDPrsnpzyZC3j6TkMX+iAI2SKfkfJZPryA9cdSbs8cT3eg17kcjOG/cgErTzcq5nIutU/92Nh3E4lr+/BIvO4oIGAREmu6M1jc+n/mYLSZOyKHVmg0y8K4fveH/xl18=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eh3CqDiO; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711747070; x=1712351870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SK0aBd2Tg31RqeqE4efItlHudPBAE0xGZkol4kgIAk=;
        b=eh3CqDiO/ILBM1o5Ike9xgWVppnr/6nU6Wz4cfl8fRvc2Tgi1/fBtVRtIWYTWDMKau
         vVTbv78S4hRF6PSluag5YgKwILHMV6pCFCXWEvjHB7An/vD2npvCki/aQYeYNKkq9+vm
         XCH6qUkq+YkCcar7lh3vJW14LIVzMOqpUzEb5OJW/C79skYDsPFCVpOZgBezr9c4wYi9
         4CK0DOMNzLtislLVM9yQdSDVApHSu0jE7oN+fcC7dS9/NfOIPvZm4IEeNkRiWuwx7rb6
         7L03w0rrFbr3Kw4rj0ioArMxEEJUECm9Bv0grqR+n7AnXY79/phZXa9PEkvgNQTgpM9C
         rJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711747070; x=1712351870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SK0aBd2Tg31RqeqE4efItlHudPBAE0xGZkol4kgIAk=;
        b=e7cVRi3/WlH6zhm2UHjhxjMNGMzCdBw0kiRNGZrD3F9Sy2FYI6dT0JzxAm6Q8e6/Y4
         N3+Uhs00X1PHInoevWtoON7kMo8YWAkAs4VfYnTFSThnVc4wethbrw0HVWBw0e/Ww8oP
         2EHTf37tsviNgSPAsg1JCId8d2geyyarVnyRYeZCsBQTTglBD/mlMiy2m2I4yB/sB6H1
         bYnryK66excoEb9oSigbbsNp5+vkXgQw7SzIZXX1nq1+dSgmDcEhlO/DuoioUPXVaBc0
         LXX7/KWDbTf9Q3O0NH+g7IOBDp/X/SNjkr3lY+cQM6yuiJnb9QzodPZNl8FR24dTed+C
         yheg==
X-Forwarded-Encrypted: i=1; AJvYcCUERtuOlGCNh+VMXzI33ZvBPsWzR2U2kdDvLuwNR7FnXsCvMA6GzCyTrDZsc8eU//coZbvHPe7F+R6hGzULlGg4z+TFtqPj
X-Gm-Message-State: AOJu0YzcaDsBlcNbpASJA/SjYACTyIQrziKr/0R/QADNO9vmVTVlTSYN
	fBH5u2AgnCCd3ByQxdGLKpOww36/eR1eh479SZIeXMFtTJ1As+WzAcJV4BnOch2p+YzXPFxySgk
	ocDfstnl3/uh1PiAfXlkT8RCWbKlGKStG4TJy
X-Google-Smtp-Source: AGHT+IGFGTkGUMvueIT/Rbb7ioKXQmsJLC9q2uWVMLN0FJu8IukA0N8cMfmV+QovgZ4y/9qL51xfw0+ynHKqeUiSvEg=
X-Received: by 2002:a05:690c:dd0:b0:614:5b8c:9b9 with SMTP id
 db16-20020a05690c0dd000b006145b8c09b9mr1542912ywb.9.1711747070429; Fri, 29
 Mar 2024 14:17:50 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120036.233641-1-mic@digikod.net> <bd62ac88-81bc-cee2-639a-a0ca79843265@huawei-partners.com>
 <CAHC9VhRN4deUerWtxxGypFH1o+NRD=Z+U96H2qB0xv+0d6ekEA@mail.gmail.com>
In-Reply-To: <CAHC9VhRN4deUerWtxxGypFH1o+NRD=Z+U96H2qB0xv+0d6ekEA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 17:17:39 -0400
Message-ID: <CAHC9VhSbOLR+yFbC6081UL87L2-SNV+gOBi2tD1YE7Th5hsGCw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	yusongping <yusongping@huawei.com>, artem.kuzin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 29, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Mar 28, 2024 at 11:11=E2=80=AFAM Ivanov Mikhail
> <ivanov.mikhail1@huawei-partners.com> wrote:
> > On 3/27/2024 3:00 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > > Because the security_socket_bind and the security_socket_bind hooks a=
re
> > > called before the network stack, it is easy to introduce error code
> > > inconsistencies. Instead of adding new checks to current and future
> > > LSMs, let's fix the related hook instead. The new checks are already
> > > (partially) implemented by SELinux and Landlock, and it should not
> > > change user space behavior but improve error code consistency instead=
.
> >
> > It would probably be better to allow the network stack to perform such
> > checks before calling LSM hooks. This may lead to following improvement=
s:
>
> ...
>
> > This may result in adding new method to socket->ops.
>
> I don't think there is a "may result" here, it will *require* a new
> socket::proto_ops function (addr_validate?).  If you want to pursue
> this with the netdev folks to see if they would be willing to adopt
> such an approach I think that would be a great idea.  Just be warned,
> there have been difficulties in the past when trying to get any sort
> of LSM accommodations from the netdev folks.

[Dropping alexey.kodanev@oracle.com due to email errors (unknown recipient)=
]

I'm looking at the possibility of doing the above and this is slowly
coming back to me as to why we haven't seriously tried this in the
past.  It's not as simple as calling one level down into a proto_ops
function table, the proto_ops function table would then need to jump
down into an associated proto function table.  Granted we aren't
talking per-packet overhead, but I can see this having a measurable
impact on connections/second benchmarks which likely isn't going to be
a welcome change.

--=20
paul-moore.com

X-sender: <netdev+bounces-83463-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoARUemlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 11104
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 22:18:07 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 22:18:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id ED14E208A3
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:18:06 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=-2.751 tagged_above=-999 required=2.1
	tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
	DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
	MAILING_LIST_MULTI=-1, RCVD_IN_DNSWL_NONE=-0.0001,
	SPF_HELO_NONE=0.001, SPF_PASS=-0.001]
	autolearn=unavailable autolearn_force=no
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=pass (2048-bit key) header.d=paul-moore.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oDDZ24243v52 for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 22:18:03 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83463-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C717420897
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C717420897
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA490B2280D
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59A813BAEF;
	Fri, 29 Mar 2024 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eh3CqDiO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE238FAD
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711747073; cv=none; b=IEFpzL+j6s4ROoZ9m+WmRtsDbZPWvRPaAOlVul1gnl+922OJOoBjb/HuCJ3iwPEDK1mF78WeWA2yuFgsFHBrCRseNrUIdkld7b6M1n5XUBTydlOahTDDwsLfuL7ySFyoJqk9bIJUeJ23RDhu4gE9DfMFDCA3hZRkhoyIXuxxLsQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711747073; c=relaxed/simple;
	bh=qXxP9z1f9YIuDyEcTXldM/7w/7mNjSwV0ZwC3PgLpPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZ+pad2noemRe/01E+nppjp0MEObj20OFHLBqEFQEGbrVDPrsnpzyZC3j6TkMX+iAI2SKfkfJZPryA9cdSbs8cT3eg17kcjOG/cgErTzcq5nIutU/92Nh3E4lr+/BIvO4oIGAREmu6M1jc+n/mYLSZOyKHVmg0y8K4fveH/xl18=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eh3CqDiO; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-611639a0e4eso21177477b3.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711747070; x=1712351870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SK0aBd2Tg31RqeqE4efItlHudPBAE0xGZkol4kgIAk=;
        b=eh3CqDiO/ILBM1o5Ike9xgWVppnr/6nU6Wz4cfl8fRvc2Tgi1/fBtVRtIWYTWDMKau
         vVTbv78S4hRF6PSluag5YgKwILHMV6pCFCXWEvjHB7An/vD2npvCki/aQYeYNKkq9+vm
         XCH6qUkq+YkCcar7lh3vJW14LIVzMOqpUzEb5OJW/C79skYDsPFCVpOZgBezr9c4wYi9
         4CK0DOMNzLtislLVM9yQdSDVApHSu0jE7oN+fcC7dS9/NfOIPvZm4IEeNkRiWuwx7rb6
         7L03w0rrFbr3Kw4rj0ioArMxEEJUECm9Bv0grqR+n7AnXY79/phZXa9PEkvgNQTgpM9C
         rJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711747070; x=1712351870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SK0aBd2Tg31RqeqE4efItlHudPBAE0xGZkol4kgIAk=;
        b=e7cVRi3/WlH6zhm2UHjhxjMNGMzCdBw0kiRNGZrD3F9Sy2FYI6dT0JzxAm6Q8e6/Y4
         N3+Uhs00X1PHInoevWtoON7kMo8YWAkAs4VfYnTFSThnVc4wethbrw0HVWBw0e/Ww8oP
         2EHTf37tsviNgSPAsg1JCId8d2geyyarVnyRYeZCsBQTTglBD/mlMiy2m2I4yB/sB6H1
         bYnryK66excoEb9oSigbbsNp5+vkXgQw7SzIZXX1nq1+dSgmDcEhlO/DuoioUPXVaBc0
         LXX7/KWDbTf9Q3O0NH+g7IOBDp/X/SNjkr3lY+cQM6yuiJnb9QzodPZNl8FR24dTed+C
         yheg==
X-Forwarded-Encrypted: i=1; AJvYcCUERtuOlGCNh+VMXzI33ZvBPsWzR2U2kdDvLuwNR7FnXsCvMA6GzCyTrDZsc8eU//coZbvHPe7F+R6hGzULlGg4z+TFtqPj
X-Gm-Message-State: AOJu0YzcaDsBlcNbpASJA/SjYACTyIQrziKr/0R/QADNO9vmVTVlTSYN
	fBH5u2AgnCCd3ByQxdGLKpOww36/eR1eh479SZIeXMFtTJ1As+WzAcJV4BnOch2p+YzXPFxySgk
	ocDfstnl3/uh1PiAfXlkT8RCWbKlGKStG4TJy
X-Google-Smtp-Source: AGHT+IGFGTkGUMvueIT/Rbb7ioKXQmsJLC9q2uWVMLN0FJu8IukA0N8cMfmV+QovgZ4y/9qL51xfw0+ynHKqeUiSvEg=
X-Received: by 2002:a05:690c:dd0:b0:614:5b8c:9b9 with SMTP id
 db16-20020a05690c0dd000b006145b8c09b9mr1542912ywb.9.1711747070429; Fri, 29
 Mar 2024 14:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120036.233641-1-mic@digikod.net> <bd62ac88-81bc-cee2-639a-a0ca79843265@huawei-partners.com>
 <CAHC9VhRN4deUerWtxxGypFH1o+NRD=Z+U96H2qB0xv+0d6ekEA@mail.gmail.com>
In-Reply-To: <CAHC9VhRN4deUerWtxxGypFH1o+NRD=Z+U96H2qB0xv+0d6ekEA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 17:17:39 -0400
Message-ID: <CAHC9VhSbOLR+yFbC6081UL87L2-SNV+gOBi2tD1YE7Th5hsGCw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	yusongping <yusongping@huawei.com>, artem.kuzin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: netdev+bounces-83463-steffen.klassert=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:18:06.9907
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: bb0b4948-f2f7-4c56-35b5-08dc5035ba5d
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-01.secunet.de:TOTAL-FE=0.005|SMR=0.005(SMRPI=0.003(SMRPI-FrontendProxyAgent=0.003));2024-03-29T21:18:06.996Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 10555
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Low
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

On Fri, Mar 29, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Mar 28, 2024 at 11:11=E2=80=AFAM Ivanov Mikhail
> <ivanov.mikhail1@huawei-partners.com> wrote:
> > On 3/27/2024 3:00 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > > Because the security_socket_bind and the security_socket_bind hooks a=
re
> > > called before the network stack, it is easy to introduce error code
> > > inconsistencies. Instead of adding new checks to current and future
> > > LSMs, let's fix the related hook instead. The new checks are already
> > > (partially) implemented by SELinux and Landlock, and it should not
> > > change user space behavior but improve error code consistency instead=
.
> >
> > It would probably be better to allow the network stack to perform such
> > checks before calling LSM hooks. This may lead to following improvement=
s:
>
> ...
>
> > This may result in adding new method to socket->ops.
>
> I don't think there is a "may result" here, it will *require* a new
> socket::proto_ops function (addr_validate?).  If you want to pursue
> this with the netdev folks to see if they would be willing to adopt
> such an approach I think that would be a great idea.  Just be warned,
> there have been difficulties in the past when trying to get any sort
> of LSM accommodations from the netdev folks.

[Dropping alexey.kodanev@oracle.com due to email errors (unknown recipient)=
]

I'm looking at the possibility of doing the above and this is slowly
coming back to me as to why we haven't seriously tried this in the
past.  It's not as simple as calling one level down into a proto_ops
function table, the proto_ops function table would then need to jump
down into an associated proto function table.  Granted we aren't
talking per-packet overhead, but I can see this having a measurable
impact on connections/second benchmarks which likely isn't going to be
a welcome change.

--=20
paul-moore.com


