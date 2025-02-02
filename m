Return-Path: <netdev+bounces-161989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E078A24FF6
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 21:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F9CD7A20D9
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DBF20B7ED;
	Sun,  2 Feb 2025 20:36:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8520B1F1
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738528582; cv=none; b=eUA/CisnjiQzlCv8tSIC1GSCasSqnMT3bRlsW58FmF4YembPCzKc4WkzVBYbyY6y3WuvkchNlD0z3yHdLrrJpGDl0VC6s9yA87dheIZrpy+FcaFLgFNzGv122ZZEZeK2EaNvvSZ1iZBUJX3xTPTEKyqpCEhKXPXudwACAXiceaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738528582; c=relaxed/simple;
	bh=QRVRLCKOuixN2sLYq5KTaz7aZufE15XA6hB6itiejqw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=co2Y/0vMIGeLD8pOTQftymFvPEfj9CUtpzKN0vrEO0bjlOaOgddS3HfZzgsWHNoo9oVIQ0ASA5k7R3aDxv+/QZG+8dNwqIVBGmAwDojfTbkE35da3vf/hYnIJbm6+83LzgMpmuE4xBR95txU4zbYE7RjXjIEVWyfXIAL3A0hFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ab69bba49e2so565765066b.2
        for <netdev@vger.kernel.org>; Sun, 02 Feb 2025 12:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738528579; x=1739133379;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQvSkq52LcoxZyVYnDtOJIbKYi2+MbFjfPMdh4lqNQw=;
        b=KCxmj4K7JrwHw1bD3RAIeKWW1B6aP9gzaoDvqpL/V8gjWFn7O+2V5m6KaW6wm6pwal
         han+OehFLOb96BH6m938f4+VcpZ5oX1OugrfWmADjfjIK2cF8LXj7d3UvBibpOYxhqKE
         EmTv38PRkvVLSHklUwx1P3yxKsCF4m/mqOQH1uMS9WRYz2q6SWDdW63JmKnaGtRqo/EH
         yzCecQ73Uj8Cm1xHZOVsuedYbeNptVZrE/gcbT0cnKVrH3pvO3X2rHXhyako86p6ep8r
         F+wJlIx9V1YeCzxw/gDA1ah5mLdXD2waQ+gMMdLiUXmbMlYrjUFDxYmVKl03vYmtEDx3
         6o2w==
X-Forwarded-Encrypted: i=1; AJvYcCVZOCqMYALBXK036iSYKhM1bs6jTWoKJQQQxLqjXwxdz/QkZ/EIZKfERb1Rcpv9NY1k+UsuW48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxuz0THb1W7i1irWILQ2axS8jwWYSJI3UxauKr4XGknW3fAe5v
	ZzGkeeZz+MS80gYiLncB4zozSKG8rv/3jgzh1MEO6So8pwV2TLHB
X-Gm-Gg: ASbGncugQTtdCgi4gm23rHjJcqG8JrXGfqTJ2XhCEYMkonr9I9SMHxAWdIWctZrIehg
	91aMmUibumZBxc19LZ7Jxf/HPnGribZmoDB9obW4dMP9QDb3Kj9QtxfuwehDm8io9Ukf5ZB57uu
	YUFqNMKZIgUTACDv1jEVT/psbT7iv4WdmGEqNBF4yCaXsbhRxxwcrXtCEMPT3Ytw8MBYdlz3YUi
	7pRZO5vUA2Ov83zeD4NA/ZveW6I3srn5m523oX7IUuUODLFXSNo/xYMMmnPPH4h8sxoQOWDQ4s8
	Al3scMm9EYgYq/k=
X-Google-Smtp-Source: AGHT+IH/GlmiiK2Gl9eoe7kA7hCIEXtDWG+Pn7+U8V9Bjy7JSlFy4w2NkuLJDBK1rYQRP8KwK6KlWQ==
X-Received: by 2002:a05:6402:c4d:b0:5dc:74fd:abf1 with SMTP id 4fb4d7f45d1cf-5dc74fdad3emr37140246a12.15.1738528578405;
        Sun, 02 Feb 2025 12:36:18 -0800 (PST)
Received: from [192.168.0.13] ([86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a310dbsm634261466b.133.2025.02.02.12.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 12:36:18 -0800 (PST)
Message-ID: <300e12d8-ea4a-441c-8906-9eaa63a1bb55@ovn.org>
Date: Sun, 2 Feb 2025 21:36:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: dev@openvswitch.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com, i.maximets@ovn.org
Subject: Re: [ovs-dev] [PATCH net] MAINTAINERS: list openvswitch docs under
 its entry
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
References: <20250202005024.964262-1-kuba@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250202005024.964262-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/25 01:50, Jakub Kicinski via dev wrote:
> Submissions to the docs seem to not get properly CCed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: pshelar@ovn.org
> CC: dev@openvswitch.org
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d7ac4dcf489..80df771df15a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17708,6 +17708,7 @@ L:	netdev@vger.kernel.org
>  L:	dev@openvswitch.org
>  S:	Maintained
>  W:	http://openvswitch.org
> +F:	Documentation/networking/openvswitch.rst
>  F:	include/uapi/linux/openvswitch.h
>  F:	net/openvswitch/
>  F:	tools/testing/selftests/net/openvswitch/

Acked-by: Ilya Maximets <i.maximets@ovn.org>

