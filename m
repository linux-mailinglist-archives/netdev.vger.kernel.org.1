Return-Path: <netdev+bounces-110153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CF092B1FE
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D9F281591
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250AD1527BF;
	Tue,  9 Jul 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHFyVno0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07C152789
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513350; cv=none; b=s/RCAJ5RhpFPL20xWXIanjij+iAw0U9T4J1hyBkCo/ysTXeAA8q434bFKC4i27yayQUs/3tjwMs0EJtETlFNM2LYBT/7h4i7gxZLWmhzlTiMutiAQ+9yOzBY1Y/0jU1xwAQ206WbFTqot9vpgwVuECMONpKkTezrn/XiKYpV1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513350; c=relaxed/simple;
	bh=ZABEDv9fiPmoTlSoMGDSxNIdsTIax3PriNpu9PmNpuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kClGGxt7zQDbWVp73oqr7eMlSzbO0BfvSshu+U3UMH5eIeNNYyX4RKSwZqZLDNNmWHdCttgHGdEuee2mEK3xS2HqEH2tKvOy/8OuOBXSGj4yJQ+m4t0ljKl+vMYMWCYGqu8LkUg9vP/V6rnAwc0dnbMiO6IBzC3UfyirAfu/GBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHFyVno0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720513347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RqegKWDpHYXVi3pN5gn0yDGeOm1m5O19WEDrAE2BOH8=;
	b=UHFyVno0+760nvvlVm1ubFxO+7DGtudCsaZVtyh/Tph5wEwMODHWr9Y6Vdrz4xcwaq6V7Z
	KSKMuAvqeACb4nmlUbkSg9/+ug9vxxnIEQzbW1fnBO8J6qbhfOFkriR5fogUEvUOWOGjgF
	IIuERD/OOCbcXelJC/tZyfCQynPr6hI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-6Opy2gfbPTaRC0XDvUqBPQ-1; Tue, 09 Jul 2024 04:22:25 -0400
X-MC-Unique: 6Opy2gfbPTaRC0XDvUqBPQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52ea2d74a4cso728379e87.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 01:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720513344; x=1721118144;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqegKWDpHYXVi3pN5gn0yDGeOm1m5O19WEDrAE2BOH8=;
        b=jRNoGEHLtw1uvMRA8FDwzIHNR0hhBeqilOZNsLQXJm5FQ/bZtnKgAgplBqOsuCjswG
         levsjPCNmBwFddPlhK3dWo6hzyf0d0YGpqbYMBBOaEfknCtIpV/H643bK6VaAoSCFXO3
         4Trb4gg6/EPOnDUUXTC5Mz/Pp3ABz27Zz5+dpPQwYH1f+RB9pfo2zpLfk0F9GDoGv17d
         d9J43xJCrIBlO+YPth8eF/TkKpDndaHAkqdtg5UHCgXRn2go2MQerVxgM476gbOqTmn9
         9kNzFM4J/ONFwLLSsosdS8vHlGzWVxbtiFF/TmK6Mx5M9Ws/8Dfj69A0o5cntlw80FDH
         7uuQ==
X-Gm-Message-State: AOJu0YxDeEFGX2VHTpLABTN6nwqogsAxUKUuMNWcUl0qtUkN4SbZ0U+e
	bzOwIRCQYMfTTt2SK5Op12FVak1UWK7s/mVYdFwxuZjVzwqXkYZP+h+QOu8DNpQNnPa5Ltoy6FX
	QmZywwjn3L3AHd5V0uXBv9U0jCBKTW8q66gbhaDRxomltRyk48k1j6g==
X-Received: by 2002:a2e:80c8:0:b0:2ee:8071:5f03 with SMTP id 38308e7fff4ca-2eeb31b69ffmr8924371fa.5.1720513344401;
        Tue, 09 Jul 2024 01:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjcXYClM7pBMJ9sSFMHY+YTmN5DPE6d78SDPVHhI7eqJEr36lojewCen9nmGyBFuooar6iNQ==
X-Received: by 2002:a2e:80c8:0:b0:2ee:8071:5f03 with SMTP id 38308e7fff4ca-2eeb31b69ffmr8923961fa.5.1720513343007;
        Tue, 09 Jul 2024 01:22:23 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1710:e810:1180:8096:5705:abe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4265f84cd44sm121929655e9.18.2024.07.09.01.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:22:22 -0700 (PDT)
Message-ID: <d8656bf85a142aae001e4275fcbc195fa2da8473.camel@redhat.com>
Subject: Re: [PATCH net v3 resend] net, sunrpc: Remap EPERM in case of
 connection failure in xs_tcp_setup_socket
From: Paolo Abeni <pabeni@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org, Lex Siegel
	 <usiegl00@gmail.com>, Neil Brown <neilb@suse.de>, Daniel Borkmann
	 <daniel@iogearbox.net>, kuba@kernel.org
Date: Tue, 09 Jul 2024 10:22:21 +0200
In-Reply-To: <9069ec1d59e4b2129fc23433349fd5580ad43921.1720075070.git.daniel@iogearbox.net>
References: 
	<9069ec1d59e4b2129fc23433349fd5580ad43921.1720075070.git.daniel@iogearbox.net>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-04 at 08:41 +0200, Daniel Borkmann wrote:
> When using a BPF program on kernel_connect(), the call can return -EPERM.=
 This
> causes xs_tcp_setup_socket() to loop forever, filling up the syslog and c=
ausing
> the kernel to potentially freeze up.
>=20
> Neil suggested:
>=20
>   This will propagate -EPERM up into other layers which might not be read=
y
>   to handle it. It might be safer to map EPERM to an error we would be mo=
re
>   likely to expect from the network system - such as ECONNREFUSED or ENET=
DOWN.
>=20
> ECONNREFUSED as error seems reasonable. For programs setting a different =
error
> can be out of reach (see handling in 4fbac77d2d09) in particular on kerne=
ls
> which do not have f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err
> instead of allow boolean"), thus given that it is better to simply remap =
for
> consistent behavior. UDP does handle EPERM in xs_udp_send_request().
>=20
> Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> Co-developed-by: Lex Siegel <usiegl00@gmail.com>
> Signed-off-by: Lex Siegel <usiegl00@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Neil Brown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@kernel.org>
> Cc: Anna Schumaker <anna@kernel.org>
> Link: https://github.com/cilium/cilium/issues/33395
> Link: https://lore.kernel.org/bpf/171374175513.12877.8993642908082014881@=
noble.neil.brown.name
> ---
>  [ Fixes tags are set to the orig connect commit so that stable team
>    can pick this up.
>=20
>    Resend as it turns out that patchwork did not pick up the earlier
>    resends likely due to the message id being the same. ]
>=20
>  v1 -> v2 -> v3:
>    - Plain resend, adding correct sunrpc folks to Cc
>      https://lore.kernel.org/bpf/Zn7wtStV+iafWRXj@tissot.1015granger.net/
>=20
>  net/sunrpc/xprtsock.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index dfc353eea8ed..0e1691316f42 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2441,6 +2441,13 @@ static void xs_tcp_setup_socket(struct work_struct=
 *work)
>  		transport->srcport =3D 0;
>  		status =3D -EAGAIN;
>  		break;
> +	case -EPERM:
> +		/* Happens, for instance, if a BPF program is preventing
> +		 * the connect. Remap the error so upper layers can better
> +		 * deal with it.
> +		 */
> +		status =3D -ECONNREFUSED;
> +		fallthrough;
>  	case -EINVAL:
>  		/* Happens, for instance, if the user specified a link
>  		 * local IPv6 address without a scope-id.

The patch looks sane to me. @Trond, @Anna, are you ok for this to go
directly into the net tree?

Thanks!

Paolo


