Return-Path: <netdev+bounces-50596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D103A7F642C
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E3B1C20C38
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BE02E82F;
	Thu, 23 Nov 2023 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQMKBqY7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87464120
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700757697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvhyGiocd9S/WTnrqejrqxwkYC77vaP/alpx7EwV9GM=;
	b=CQMKBqY7wT4J0kAZuksI3FdYBJE3ux4zCzZ9wotrWA23ciZQ/F1DJCkMwlq3qiWoVU2QP/
	vTvUuzgMyUH1CvnkEpcUSgew//eqaYedszDzHH8nxGffgOTyL7fxfZxaileU7Y0CKd0BjJ
	Y4GTzmJqyTVl++C2Of22cmn+JHpX3AY=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-NTzPz6xmOp6GxSoMrpSzEw-1; Thu, 23 Nov 2023 11:41:36 -0500
X-MC-Unique: NTzPz6xmOp6GxSoMrpSzEw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1f9847123e4so438568fac.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757696; x=1701362496;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvhyGiocd9S/WTnrqejrqxwkYC77vaP/alpx7EwV9GM=;
        b=TbJHgZ8s3zmGyZEGedkszkb5hNoRhbzJAMcee8d3uNBMlcf8mEUcncI1XEtTydqEgv
         V8Km0mYgGPgE2Q0fb4wPTxcz6xnjGpvMXEM5uE1c6wt+14QEdhmzB5YgtuzDqCIy8pZ7
         4cK4MsK3XA6MFr6betYivMMqtNt3LDmpCGKBspFn0acwc5Njj6XBXTUsjWAeSo7XBHvZ
         aJUb+NAlQeLalsD34jHYz5laXWrsxxhOVL50aUtz1UIoNOkT6+gNtXJFOYdHp96trPNq
         9u90eeb8Y6ryi+d8gPTprD58QQJPy809+q/c02ClkvA05KnIFbFe2R6Jj9ADGMBAyc3S
         gB2A==
X-Gm-Message-State: AOJu0YyQ8an7SdPmvRWcsT2iAxye8IEh7SpnaiOVB/9DFuE+5CcZEIEr
	xV7P2Exq41c9N827hDt3T1G4c7N+GFT5V1fK2WNYVaSFZzegiBlmTN682ib7axo8L3+X6JvSuiF
	x+L8hgyPCf5bm1qp7
X-Received: by 2002:a05:6871:7a0:b0:1e9:8a7e:5893 with SMTP id o32-20020a05687107a000b001e98a7e5893mr7587429oap.5.1700757695790;
        Thu, 23 Nov 2023 08:41:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+04e1Vh52SolmH+Vji6UaC0k0qOLwcDodNnPANnkt/IexnCF9rxr6HrQ6ayqhb8e6Z3MdsQ==
X-Received: by 2002:a05:6871:7a0:b0:1e9:8a7e:5893 with SMTP id o32-20020a05687107a000b001e98a7e5893mr7587413oap.5.1700757695521;
        Thu, 23 Nov 2023 08:41:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id o3-20020ac86d03000000b0041abcc69050sm582431qtt.95.2023.11.23.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:41:35 -0800 (PST)
Message-ID: <c1f1f869346f4d6fc90eac6d131454b85fa676be.camel@redhat.com>
Subject: Re: [PATCH] mptcp: fix uninit-value in mptcp_incoming_options
From: Paolo Abeni <pabeni@redhat.com>
To: Edward Adam Davis <eadavis@qq.com>, 
	syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, martineau@kernel.org,
 matthieu.baerts@tessares.net,  matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org,  syzkaller-bugs@googlegroups.com
Date: Thu, 23 Nov 2023 17:41:31 +0100
In-Reply-To: <tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A@qq.com>
References: <000000000000545a26060abf943b@google.com>
	 <tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-23 at 09:23 +0800, Edward Adam Davis wrote:
> Added initialization use_ack to mptcp_parse_option().
>=20
> Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/mptcp/options.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cd15ec73073e..c53914012d01 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -108,6 +108,7 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
>  			mp_opt->suboptions |=3D OPTION_MPTCP_DSS;
>  			mp_opt->use_map =3D 1;
>  			mp_opt->mpc_map =3D 1;
> +			mp_opt->use_ack =3D 0;
>  			mp_opt->data_len =3D get_unaligned_be16(ptr);
>  			ptr +=3D 2;
>  		}

LGTM, and syzbot tested it.

Acked-by: Paolo Abeni <pabeni@redhat.com>

@Edward: for future similar patches, please add also the=C2=A0tested tag
from syzbot, will make tracking easier.

Thanks!

Paolo


