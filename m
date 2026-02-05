Return-Path: <netdev+bounces-256946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O9kF7UYhGk1ywMAu9opvQ
	(envelope-from <netdev+bounces-256946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:12:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5C6EE764
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B71633004422
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 04:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877AE29B77E;
	Thu,  5 Feb 2026 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Te1rryoe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3Dh8Vbj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB0286430
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770264752; cv=pass; b=CYClxMkvZMp+sCfmB9WIjPBKcFRtGLSU1C4VxucUe6ovj2GJIZEdUG+E2QSiFtd66yDP5TORuSgNGPgXuB+w60/TogZwBnxxWrOklN5wLPPq8QFcE5QUTxMEFrChplfLOjl4d/t3J2ikp2BH/lSfXKwWtrXR0Ryaeis1Mdv4sFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770264752; c=relaxed/simple;
	bh=3TYZrhXeLdwlvT3HOHosF3Zz6ave+UyXvM0VGb5I6kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DB5OSUtBPpEziTaWVfLziBAYDWHbWJXqPaF+uzxS27EyM4TIft/27Co1kDJSPpS/wWkh42zTRpU0G9wj0ohJKuKvfdISkAWk7gX1hZM/ev5gtIK5cWIybylPP/SSNoqHpVQ2YyXlonz3qLkmTTbUyGHsbAxxCV0bRZMbNlGaIUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Te1rryoe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3Dh8Vbj; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770264751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zewgyfu9wLqA2DfawEOVacfHlxdGI5cP4c+2P+5IbE0=;
	b=Te1rryoeatP0zGcM8aiXssEDuuJZtD5qguichaIf6NoHLagKRLMGgyTCsb+1VCB4K3jeY5
	L52gnyWHUtHBPIlvdXSfm2B03LafBNL5mNc4p+neAYL1ci9S3pZgbCg13G4QC2Ja6JWx8F
	UjuL8I8nRAEK5ZF965wuqw809ZHK5xc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-Pb3ur1jQPTGuBG7MJqE3oQ-1; Wed, 04 Feb 2026 23:12:30 -0500
X-MC-Unique: Pb3ur1jQPTGuBG7MJqE3oQ-1
X-Mimecast-MFC-AGG-ID: Pb3ur1jQPTGuBG7MJqE3oQ_1770264749
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354490889b6so745853a91.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 20:12:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770264749; cv=none;
        d=google.com; s=arc-20240605;
        b=JbW9VKYBEPIR7BmFtt2Zb5X0jO7m82T/QSRhp/c8NJAC3Zzkxap7LTCCDI/kiILEcC
         S+9ESlYJU3dXICaMIwLIykE5bbw8tP+yU+mpdzV4F2Xo2fd/TJ2mUGCFHUliotIzJzLS
         D0SLtUG04Q8gxiDjwQ2S2SAlYI/EV8ujDaHDaKfVeUkht+IR+K7keTUtqOjO5G7Zx+E0
         a3ss/rbjJ6ZwCfp5PZ8ZBPDYeuqvoEUdHorog2wmDdyRqlfBjhXvb7fKqG/FOHRcC0yk
         Kc3XbIaNqjrUMFecFHDS2Zh1tYv9cV+E83vV0rDV+Cgce+GvbKGDNdnvFsmNOsg6DXdq
         fzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zewgyfu9wLqA2DfawEOVacfHlxdGI5cP4c+2P+5IbE0=;
        fh=C3E4OaCYX+qqJz75FcGbxiRqVqTO2NTal/1pEUBv2cI=;
        b=UDU8cV5YSypJV1kP6ny4BH5xBuRypub77/u73IW4aqgRhS0ajchjxS7J8HZCtwejHL
         XRmAP7eApdNYTw/OOg058ZTXVkFEDnpXmKNZXJE+M+G6tDl1OLSwLQLlQ1se4wV/XclH
         IrMIriw4frSTs7h6HLutOZochf1vKNrc76VS3p0F3d10suSe1nu+6log+s4BI06/XvOi
         MVE/nASrJRiBUxkcJRgSXVFuELggfykGrwUABw4lW8ObKCpK9YMpLCgGYTt6kU32trjM
         kjaHOVrrld4VykHBKK3HEhO0gmKLQQm5f4boSPH2kykmZ5VxEEe9QkhYbuzM+LCNHi+k
         bZlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770264749; x=1770869549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zewgyfu9wLqA2DfawEOVacfHlxdGI5cP4c+2P+5IbE0=;
        b=T3Dh8VbjghDHT9Q4KXAbmjtnwITcg0HJdJzlu4gOyBaAf2Mqve+WjZWSYfQUGoibXA
         WLiUhCe54WvqC8HlRWhypf4F+JV5Z3zrZob6gfblz7BnXKX+hMNkpd0XtcrzFob5Z/dI
         3Lhttjk05rx3Y4TAG0DxM0ZI2n8oN8Bt8HmeqA3BzByE3iGIEwLbSQ6KStqyJggoVxPp
         AfNGBKUQ53Mr41WI2WxT5cQx3fqE6zINfrgva7XSo5v3ucAebXHvnbDgw2pOrDvnhS0T
         +2FqkQhnStOgUUwPpAkc/vtc1T1Zp0kCAfgvDEKinC+9szaYxaD41FOw4UCPWlcchMKc
         woCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770264749; x=1770869549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zewgyfu9wLqA2DfawEOVacfHlxdGI5cP4c+2P+5IbE0=;
        b=jNW5fB1tPu4H0lFu8IAhCtL2q3ukKL/iLq/HrrlYBOzpb9dB2RPjd4Gz9ICF50Jjfn
         U0qB67VDa2pSG03dlgC4B4I3epCplJiboZCpYbdXOnSQ4vcEPSM7jD+52ZnUdSOhSH4/
         0frNirY2QWFV7SQUDmn44f7m5Y2aRnFGq9UgWeo5sls/8kAQYZg1Kg7ik+Oce+hCzlmv
         uJhmw1o2chffg2UqisIe6X0wdP2I+UQDP3+oKu+RZ7TUGo8DTYhZ1yD9+OlgzS97WV/x
         GrrI8tSqh03yJb4iMu5DNPJ6ry+BT0azq+kkvV6gOpylHXGD43BSE+ewbUUQmxPpMQvA
         rq8A==
X-Forwarded-Encrypted: i=1; AJvYcCWtKdDE6Qnnv6ZGYvvm6OQT3J8xqgYnVh+MZtq2gNcqrnlctAKgKL5WHuM+9QhhwfD74BUp6IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4aIlgmEhroxxcZwCxIBFjScugR0H9UHLR0+L7dw32Qq1kuq/0
	QYM7/FKSo7v6//iyNEL2i1J5oL9j7EOUlg6E4cWi2Om7e4aug/wNlQROhYTDSMf2kjWAbXC74Cc
	asQapIxq7jk50BxC/E3APjGvqooARGSKIv88xZjDFaVbzuYPFgvXPREGdhQZfENIC+F6UB3e9kN
	1lxudwz39y5r8/PMlKqKa4eR9katqqrOAB
X-Gm-Gg: AZuq6aKyAO31QkmJj+IWX/kcqp84q3bzjGg96KulS4euIjEXy6g8A9v6atKy2Vw9v0l
	jtVuegqcnBsh3hsIhz9TELXK5fUDvZ6DDpFnKDA99XZI4/aNcT8qubJFK1NUVJ+FPZ4jsIbI5vh
	i2zf0ZKrkvXt/Ckosw3Nx4FL25Vjwug3alJ3iIA8eScCRAiYk6rghisYP/nSWBCkn0wA==
X-Received: by 2002:a17:90b:584e:b0:354:a065:ec3b with SMTP id 98e67ed59e1d1-354a0662c95mr749310a91.27.1770264748985;
        Wed, 04 Feb 2026 20:12:28 -0800 (PST)
X-Received: by 2002:a17:90b:584e:b0:354:a065:ec3b with SMTP id
 98e67ed59e1d1-354a0662c95mr749287a91.27.1770264748561; Wed, 04 Feb 2026
 20:12:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204193617.1200752-1-vishs@meta.com> <20260204193617.1200752-3-vishs@meta.com>
In-Reply-To: <20260204193617.1200752-3-vishs@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Feb 2026 12:12:17 +0800
X-Gm-Features: AZwV_QizAHLNWkiETUatO6ZkdAJ2xnGs0u3Ghu1W7Yk4-H7oDiMym-wpgKMXGqk
Message-ID: <CACGkMEtMgNpoSeUUFt10LJZqtTpi1atbPJwpXDf94AyzVKxvqQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] selftests: virtio_net: add buffer
 circulation test
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256946-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,virtio_net_common.sh:url]
X-Rspamd-Queue-Id: 8B5C6EE764
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 3:36=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.com=
> wrote:
>
> Add iperf3-based test to verify RX buffer handling under load.
> Optionally logs page_pool tracepoints when available.
>
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  .../drivers/net/virtio_net/basic_features.sh  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_feature=
s.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> index cf8cf816ed48..fa98505c4674 100755
> --- a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> +++ b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> @@ -6,6 +6,7 @@
>  ALL_TESTS=3D"
>         initial_ping_test
>         f_mac_test
> +       buffer_circulation_test
>  "
>
>  source virtio_net_common.sh
> @@ -16,6 +17,8 @@ source "$lib_dir"/../../../net/forwarding/lib.sh
>  h1=3D${NETIFS[p1]}
>  h2=3D${NETIFS[p2]}
>
> +IPERF_SERVER_PID=3D""
> +
>  h1_create()
>  {
>         simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
> @@ -83,6 +86,84 @@ f_mac_test()
>         log_test "$test_name"
>  }
>
> +buffer_circulation_test()
> +{
> +       RET=3D0
> +       local test_name=3D"buffer circulation"
> +       local tracefs=3D"/sys/kernel/tracing"
> +
> +       if ! check_command iperf3; then
> +               log_test_skip "$test_name" "iperf3 not installed"
> +               return 0
> +       fi
> +
> +       setup_cleanup
> +       setup_prepare
> +
> +       ping -c 1 -I "$h1" "$H2_IPV4" >/dev/null
> +       if [ $? -ne 0 ]; then
> +               check_err 1 "Ping failed"
> +               log_test "$test_name"
> +               return
> +       fi
> +
> +       local rx_start=3D$(cat /sys/class/net/"$h2"/statistics/rx_packets=
)
> +       local tx_start=3D$(cat /sys/class/net/"$h1"/statistics/tx_packets=
)
> +
> +       if [ -d "$tracefs/events/page_pool" ]; then
> +               echo > "$tracefs/trace"
> +               echo 1 > "$tracefs/events/page_pool/enable"
> +       fi
> +
> +       local port=3D$(shuf -i 49152-65535 -n 1)
> +
> +       iperf3 -s -1 --bind-dev "$h2" -p "$port" &>/dev/null &
> +       IPERF_SERVER_PID=3D$!
> +       sleep 1

Nit:

It's better to use a more robust detecting instead of a sleep 1.

Thanks


