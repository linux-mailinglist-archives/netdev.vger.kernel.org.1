Return-Path: <netdev+bounces-72030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3FC8563C7
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350EC283507
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961912F38B;
	Thu, 15 Feb 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+Q2X8RH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE118EA2
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001780; cv=none; b=ATpI00xi/syNSdPDkoTw/lN9xQ/gaYZPPzfh9aWEf+/xa/0/6b3ODdStWqbuAmtZoQO2q8wIxkXD3QPVkPgp7s8jVmCwqn8GeX/JXmvkLugG0cQg2gBTrQBvcmUp9052Ok0nkFHY/bytFUJGadfPXzsyFsOwMbo0JhtwJVOgNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001780; c=relaxed/simple;
	bh=BGzUuv+VN38ZW4QWTSmZ91BtiiRaiPfcmZPr1XwoqSk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m4oS1Qm+i6YW3weWL4FLkFnGfDzz43GRi6FZ+NNfcqvcHlWHGrWYd4qAkLgaerUBTrpK57NIItPS9ru9cxp++fvbmb25/itR6BDLNoRyptpebRy8zuhUQEIlh5KT2rlKQfY97gzsUry/+ev7bvXkkU0kOm06jRYV0emw68WTkKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+Q2X8RH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708001777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BGzUuv+VN38ZW4QWTSmZ91BtiiRaiPfcmZPr1XwoqSk=;
	b=A+Q2X8RH5g0PCKosxL3I0kDnyYla/u7gDrTO8fPRMkOaC4FwJezwnm8GbnEJJsF6UR+8KN
	jr87ublle5PrmO6xPv6YS6MuKs+8hmAlBCaGbA91T99/obqDpc1bX4NHJDVQr7HURpwF3i
	QNrMl/tRZnTy+FE3Xcn8ysnb/h+THJI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-Ptv3mq6UOGO5H-FMS6XhBQ-1; Thu, 15 Feb 2024 07:56:16 -0500
X-MC-Unique: Ptv3mq6UOGO5H-FMS6XhBQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e4303fceaso1924185e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 04:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708001775; x=1708606575;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGzUuv+VN38ZW4QWTSmZ91BtiiRaiPfcmZPr1XwoqSk=;
        b=SMDfIMPX8jH4fxAMxkh/Vvuo++OFYurNmqu1YtJ8JXh9SB9lzZtSqVjI+W05eHRIRY
         iLBW4Y436h5IA2WuDP9zJncfPavO9YvDad5Mc9StbDTcZJW9SHq8Q5DAoeTzoI/x4oaD
         qm+XxJ3sJdueZ2OCznjeeWgKJoMYC1c1Qo0Z1vDtAiAJSaSPgXQ36me00/bBpbcwxhU+
         un173Ou6BgJaiLGHjToKpPM5XxTgN2kotW6yPovGC+6r8zlQVVNR5KKn28VOMGofWvXj
         +VKrHqOxg7H+ld7DWS8eKhq1UwjISvjbc9Q8/g9LQ8JZvL/56oRxKWTFaJbDb0qhxbBQ
         YKiA==
X-Forwarded-Encrypted: i=1; AJvYcCXMfvl04rBSSbOIj6WSHWniS90t025fESQe2gu0fsgd44fVItJgILtjFLG8WB+AdyUWOM7KELxGSy44qotDBPZqaNtf+tp8
X-Gm-Message-State: AOJu0Yz/DvX1dm3HLnqLh6SU2XLfteSwJIA07DwqLKKvt9CW5c1Xi/SU
	QXFsuinLeovE0rbzSNGG1qgT8onhZ+7avmv+q1Tb/lB/eR41sNU0Ew5yxNGynxhlTzjVoldJ5pK
	2zFO+1/qDoRcGPh/ZN6HkZyLKgN2tGBolYo/q57RTC8J81trPWQxXIZ+iO9VuUQ==
X-Received: by 2002:a05:6000:1f90:b0:33c:fa03:57ec with SMTP id bw16-20020a0560001f9000b0033cfa0357ecmr1380228wrb.0.1708001775146;
        Thu, 15 Feb 2024 04:56:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm7E1fKMf9Zg6jK1SGkYb6wjcsNocNMQK/8/Xd2Eh0WWuJql8xuC9auLAmN8dyBKUph1QhNw==
X-Received: by 2002:a05:6000:1f90:b0:33c:fa03:57ec with SMTP id bw16-20020a0560001f9000b0033cfa0357ecmr1380214wrb.0.1708001774705;
        Thu, 15 Feb 2024 04:56:14 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-227-156.dyn.eolo.it. [146.241.227.156])
        by smtp.gmail.com with ESMTPSA id bp21-20020a5d5a95000000b0033b5ee36963sm1841723wrb.23.2024.02.15.04.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:56:14 -0800 (PST)
Message-ID: <789d5cc3c38b320d61867290115acafb060ca752.camel@redhat.com>
Subject: Re: [PATCH net v2 1/2] net/sched: act_mirred: use the backlog for
 mirred ingress
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Davide Caratti
 <dcaratti@redhat.com>, jhs@mojatatu.com,  xiyou.wangcong@gmail.com,
 shmulik.ladkani@gmail.com
Date: Thu, 15 Feb 2024 13:56:12 +0100
In-Reply-To: <20240214070449.21bc01db@kernel.org>
References: <20240214033848.981211-1-kuba@kernel.org>
	 <Zcx-9HkcmhDR5_r1@nanopsycho> <20240214070449.21bc01db@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-14 at 07:04 -0800, Jakub Kicinski wrote:
> On Wed, 14 Feb 2024 09:51:00 +0100 Jiri Pirko wrote:
> > Wed, Feb 14, 2024 at 04:38:47AM CET, kuba@kernel.org wrote:
> > > The test Davide added in commit ca22da2fbd69 ("act_mirred: use the ba=
cklog
> > > for nested calls to mirred ingress") hangs our testing VMs every 10 o=
r so
> > > runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
> > > lockdep.
> > >=20
> > > In the past there was a concern that the backlog indirection will
> > > lead to loss of error reporting / less accurate stats. But the curren=
t
> > > workaround does not seem to address the issue. =20
> >=20
> > Okay, so what the patch actually should change to fix this?
>=20
> Sorry I'm not sure what you're asking.
>=20
> We can't redirect traffic back to ourselves because we can end up
> trying to take the socket lock for a socket that is generating
> the packet.
>=20
> Or are you asking how we can get the stats from the packet
> asynchronously? We could build a local async scheme but I'd rather
> not go there unless someone actually cares about these stats.

I *guess* Jiri is suggesting to expand the commit message describing
how the fix implemented by this patch works.

@Jiri, feel free to provide the actual correct interpretation :)

Cheers,

Paolo


