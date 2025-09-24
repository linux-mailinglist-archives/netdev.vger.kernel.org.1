Return-Path: <netdev+bounces-226062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1C6B9B808
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 20:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB0994E2212
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC156314A90;
	Wed, 24 Sep 2025 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtBmNeMB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289022FD1B5
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738973; cv=none; b=CqA2YYCWv/M3/x58KuzLPmgA8/xVhCZltAu82ZW6siqjedwfmXjNZ5YIrST8Ef37rnHHIRzIjl4cIg4IJH7UI/FtDQyXdiqLE+1RegzIe3B053Bbq4gGb2o06dScE4/46znxxC5Mr33ArFqExXvKpIZazyisL9GziqjlbfxagqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738973; c=relaxed/simple;
	bh=2aLfX7a8qrLe04EEuCsSWXOjT7NO0ExrjFnQIBlHj04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcFyAN2+1dMzti2uSybEgpCnhcDPzoMdRJCX0BkT7+PUX8CJeILcQpKMS3VC40yNqtIzgkUOT14R4VfnEFiQBbPA9a88Llf/PoLYSIpYg3OSsJ8ffoXU7zfAtDSkelc2FPumy42FhbBmKIYZm591dMEvNJwBtBHI4ZKa+kUwB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtBmNeMB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27a6c3f482dso910655ad.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758738971; x=1759343771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuMDAryKyhqMDr6B+XSq4gaOR0tjLhHQ+hf5EwbyoXs=;
        b=FtBmNeMB04FY3JGB6PNvtOFMiiWfAj4garK3jVjddYu+aBCpnKJv62bLvq1W//T70a
         y4kpNyp7rAle3Axx60PHhi6UEdug4mVpmTWaiXKH7HrgfEK/PWpxCcW0GSz76SJe4Dr9
         occhHLHIxPq0kTA95Jz5yBEygNFimb1rEmkA1gh+VV5Pqlk8iMz81SJJZ0+AJISXUxZt
         wdtaeEH1wwkn7kSP5ttEoRqBmeHlsXKKhB8JQMcokPHbGgOVheMDGjqihXZULw08wYio
         ZlNFk+yeDUGN96q/XFWEIvy11lkr81KqELV2YRixghqOF9U1I8bvBJ6ZhOrkKSss3XPz
         GONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758738971; x=1759343771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuMDAryKyhqMDr6B+XSq4gaOR0tjLhHQ+hf5EwbyoXs=;
        b=eCztQ550BvkpWrrubG+6WbmuzPzpSPALvWtmqIlALtE5hIdn16bZPfZAnxsYtucCCe
         L0GdmdkqStZNx9jwN1xrn+6o4GBKMzNLlx2jQGp+FrCkdTOuTz+psBggCGYDUkVpKGp/
         M9BoEyhVBA8BDs/RnYAsq9qgLEz+xzQpMRnx+zg1mBjVSVpiy9NenMUWlS55/8K98xhe
         oY49zdMhsvhR0a0l1kU7UxBvDoI/nGGZMH9NRPyNhBn8HIkNvSNNhPIiYzU9Ba9vKEVg
         rETI/F69tkdnSDZwhi2nOzArTaPISnEMJGhAH9vad/8VF0MACtj+r+6A4wqn3y0cPWaD
         pkDw==
X-Forwarded-Encrypted: i=1; AJvYcCUZimXf2T2rQOSebhiIGGx6V5POV83Kk7PUH/g3/k7Uok40DPIobOzQFDVEgq4kJnc+OG9/RPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOE4H3LLojUl58edhpgy2GD2YY2LH3x8t3CjIONj7ZVVpsSr9c
	39pU65eR//wK7jeozzsR8/fchyz3qHCT3Cyy66+L4I4I42trFZUbY6Ft
X-Gm-Gg: ASbGncsZ/sEO+u8VQ1hhIDNdbg18TPYrO++QX+Sd413Px3nYIKaSUv24u4NykK4Rrjw
	8pv+SBsPOKkCOZ9/c8KxPTQwq5ImReR5WfngREA1TbC2Vd9V6aj0RR6JqejSByJ6PRUTw6BEFEc
	AMs5gWbBA2lVqX+FzyEVeLqZZKvSFjk8SMV5cHZBS9hfk4rNOUbkYdf8vFro/gLcOJbK7ZWRNmM
	ZUxJrs3XdtfFZjIxz4+OWo1JWNAkMzHhnRviD6sZLZgEtXZnMDyZwx8ZC/RU2r7xP5256G+3PjB
	7rTCq4zz5oRPZzIOecOgx1UaKeZo+kubQU69BGLRB3FgDUyUispneP9Qs7NuzM1SEMN0/wGKQiJ
	R4hpjv65fHnHx0jaGvdIvDZQ=
X-Google-Smtp-Source: AGHT+IFpCuPX+NdIWL+u5IkcBx4+VbKV/4827jy+s9/WEKKxG/dZ2BXBXewNNRlOFgtg+akJrLG03A==
X-Received: by 2002:a17:902:dac5:b0:27a:6c30:49c with SMTP id d9443c01a7336-27ed4a56ba4mr5732905ad.27.1758738971104;
        Wed, 24 Sep 2025 11:36:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f4c4:bad6:f33e:ddc9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd90367sm3096304a91.5.2025.09.24.11.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:36:10 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:36:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
	netdev@vger.kernel.org, linux-spi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Javier Carrasco <javier.carrasco@wolfvision.net>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Matthias Fend <matthias.fend@emfend.at>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Paul Elder <paul.elder@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Mark Brown <broonie@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 11/16] Input: touch-overlay - Use
 fwnode_for_each_child_node() instead
Message-ID: <amnjiro7qhreys4upoh6ggqurom6gudk2gw5ayrfjhj243wqwh@o4hf6txhsm62>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-12-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-12-sakari.ailus@linux.intel.com>

On Wed, Sep 24, 2025 at 10:45:57AM +0300, Sakari Ailus wrote:
> fwnode_for_each_child_node() is now the same as
> fwnode_for_each_available_child_node() on all backends (OF, ACPI and
> swnode). In order to remove the available variants, switch the uses to
> non-available variants.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/touch-overlay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touch-overlay.c b/drivers/input/touch-overlay.c
> index b9fd82c4829d..7eaaaef1bd82 100644
> --- a/drivers/input/touch-overlay.c
> +++ b/drivers/input/touch-overlay.c
> @@ -82,7 +82,7 @@ int touch_overlay_map(struct list_head *list, struct input_dev *input)
>  	if (!overlay)
>  		return 0;
>  
> -	fwnode_for_each_available_child_node(overlay, fw_segment) {
> +	fwnode_for_each_child_node(overlay, fw_segment) {
>  		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
>  		if (!segment) {
>  			fwnode_handle_put(fw_segment);

-- 
Dmitry

