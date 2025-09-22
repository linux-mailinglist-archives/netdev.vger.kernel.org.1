Return-Path: <netdev+bounces-225294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EC0B91FE6
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205AE16C808
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AC92EA744;
	Mon, 22 Sep 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBlmArr3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4D2EA72C
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555546; cv=none; b=NKIqYs6zwVFufHFYNrhlQI4+GK8Dl4tMmuf3D7qCk6qYxAcCgD+cv1gaBf1yPlIwDn6MYidmpZiKkLhH5W0C3XUXdkJqHu6R2cND3ETVzuRwtAoyduBA7sTR8D0zhOrFzMrjVqnk5oLQXyeAU5JYcmLTKljW32fHuzamCEuXeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555546; c=relaxed/simple;
	bh=+pi56O3b51xWpK/gynXOWLU473m1ZZ7txSI/RgTjuqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFOCmTH+gc1lA+rYYqWlAic8bEBuidMchrIG4h+K9+TKiRuDBfduVEU8DDwegXhSN2DUIuzbVqDZNEO8Y04JZjTLaR+A0nW84z36MeIIe6bNzS/veuAzaJAX8LS8mSr9j+Nb0aV5lvQaZ40MM/3354rCoasGL6pEzDJXInm02is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBlmArr3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f1f8a114bso1431677b3a.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758555544; x=1759160344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+2ag/iV4mxazDtCnvPykVJFi1jwwbRDl7dA4X3Ytkc=;
        b=QBlmArr31oLL8Kd3LI497dLTRX/SlDIDr77UHPMRb0qMIjWX1jN1pGgWAVgp0n3wK8
         5iLJ9+1fMAN22qftQ+idM7DmNplpXnuuU6SrQ3fj2iYSNofBsyVxeJG6KV4bi3MO1MmL
         VaSBYmTAelgPP4vIWp1EeF4QkeePuT4BfpmRxv5EVT/24XGrJ4VVtn+Z81eAh5ukZxSy
         zEj/99O4KL2z79o/YVrqjulLaD4jaC2uSlUy6L7BTmf6cmNWcv/wUXgpllef9xGfuJc6
         04BOvmM7dPeIUJ6a/1a+JsPQgFbTWRh0L5qFs8X1QoeRJ7BpfBpuZeUdON9Kva4MwLN9
         ITXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555544; x=1759160344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+2ag/iV4mxazDtCnvPykVJFi1jwwbRDl7dA4X3Ytkc=;
        b=kEFEnPqqfmYJEW/9RRHPuqQuPUM5uMwGyHJpdXuyjEMZlPGkdIfgo1OHjHWAFzOg/a
         NtmX2AZdLWB+zc8jmIxT28xHtJMNJFYs+acnKjJoRoknMU990zhNzCwYBjCo64gusfxI
         9dcKJVpkz99VhEe0QrciNKq11qsZdwSoun/kDysGvSzcCqO66NQ+7T2KW+n/kycgNStd
         82fms1HB724ZKDneY4YXMlzF+EanVFdIGzHpfzePIA86ntlOH2/McqSnc9B3VginmSBY
         WaVWEaKQlYFJh/xYpAo//L7wMfNC/J9u1ysuAsDnv7TmPDAUr4dvlwc/Sp2gAh0RxQHz
         QLyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNJvaBMJ7N+IG2oo3vyQSHFbk+4nkM6WXoj5pws8RgVOpu0wUKU8d2lghPDxsMgpgJyiKOckA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+CHbbZCEb6tUnRFIol1b1YpXZGSJBBZCAScQ+Qp9Znm++qeDP
	fgY11NFD5JWlYwClsGXdDLSnkFYm4wBb+QTe0vg6i0ZO7dRcsHbHVX0=
X-Gm-Gg: ASbGncuPheEaWQEY7jtBnstUPhdeVtQevaVttMhZXK4sOmadEt4GdtSzCMfCF0oNm3r
	PtlOUlnXQ2XfPY4luowwFaMqgiSTDIOKqk661Ks1OOoFFAyGxCSSzIH3nglelU57btO7pjYJ2Y/
	XHJXnTiO77g5YOFg1l+Na7MUsyYCqu/8Cc/1bR8bV4HwLrmB0bRcxz154DEHY6d1644arY0AqX5
	w+crau3czjsBvPEJDS0k10BawPCbfYlquJGT2qswfCmW6Kgvo5HqPRzoIkpgpWo2oxWcV2KOhQg
	P+h3rhB0sZ9iDz+LVsiftvt5sZQEOdJXbp1D7ZS65O62bAJxXyw7FRZLbU/IspgQuJxJMOCTQbl
	JKudsTWxv6sUOFNrmKy/vUTLg8tlxnFuXK484V6jhQiboJEOiIhV5dLXl8j624VPvUW2HthzK0j
	ppmHXuPJWw3paq+G0/2p/nc1TvnobpR0gakg+t81quWLebr8JHrtFHA3+ypF6vuAdDU9Ry/mOzh
	9EV
X-Google-Smtp-Source: AGHT+IE3TS2ZT2iVwXx8IVuVRd65DCwplvU4zTMTt2k1/M2gr1xCgjuzcB7lSRGACmTncGG25EZblA==
X-Received: by 2002:a05:6a20:4327:b0:245:ffe1:5619 with SMTP id adf61e73a8af0-292189dd44emr15040347637.23.1758555543694;
        Mon, 22 Sep 2025 08:39:03 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b55149526cfsm10207767a12.36.2025.09.22.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:39:03 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:39:02 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 1/6] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aNFtljcYeLK3uVo3@mini-arch>
References: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
 <20250920-xdp-meta-rxcksum-v1-1-35e76a8a84e7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250920-xdp-meta-rxcksum-v1-1-35e76a8a84e7@kernel.org>

On 09/20, Lorenzo Bianconi wrote:
> Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> checksum will be use by devices capable of exposing receive checksum
> result via bpf_xdp_metadata_rx_checksum().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9ee3548098b0c933fd39a4 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -61,6 +61,11 @@ definitions:
>          doc: |
>            Device is capable of exposing receive packet VLAN tag via
>            bpf_xdp_metadata_rx_vlan_tag().
> +      -
> +        name: checksum
> +        doc: |
> +          Device is capable of exposing receive checksum result via
> +          bpf_xdp_metadata_rx_checksum().
>    -
>      type: flags
>      name: xsk-flags

nit: let's fold it into patch 2? Will be easier to git blame the
feature..

