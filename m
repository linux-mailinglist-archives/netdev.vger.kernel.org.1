Return-Path: <netdev+bounces-244483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E8BCB8B55
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 12:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDF9B300B922
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 11:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADDC31B114;
	Fri, 12 Dec 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cMeOE3kA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A230BB98
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538719; cv=none; b=NaZr98BsAJu59oE22q2uL73UWWSsb5LlYsc//3BCBD+9HcmAIOg7PuYkZlO3kGvtF0ojM78xC+rmJOL2FAa6ne+Z5pcIRKtMzO7iSOsrfCSr5YbxY0tmhI9YHJuXY+t0pCFrkHVijzCDMW3/5qkZGHds1jJgSXy+3/HHqPxW0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538719; c=relaxed/simple;
	bh=hTO9aQVk1BjsYhwnOVt6ys9wXkYUKex0i/wuCIuc6wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvSiXg5mwU/gmsKXaMJO5seIOE/JLQpXeFfGFIiSjalkJco9PYxuD7BiR1m1vbFrWIiF9+rvamPrHZXY3LVzYTYYQT8mvqumlho5CF3PzqzDVrBS2TipsNNUTmQA5mtc9XCvp3TqW8RS7Q6OjjKjfM8qQUfXSTlWu9/zvtBy0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cMeOE3kA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so579678f8f.1
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 03:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1765538716; x=1766143516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEnn545SHxpJYbhpEqJ4kau8ivvtfD9Ghf76lIvPG6E=;
        b=cMeOE3kACU3Ha23b+to+W7aPNYOihqvQuOjwSqGOXZ0gICe92Db6JhvmQ6BJ8/qtEw
         PR194sicrzJkAYlJ+jmzXgJvZk09uDchh9eOJQWn7xKmHuA34Yt5Hgkalp6DkBvNaIu1
         qCkppwq/uAyrsk4N3Gycwl6RZCj2PZgWbgeUSoBIRRpLNHKNREqryVW18rEw2cDBoZkO
         fQNzhs4ug4EllxjaAewe+1nbz9dsEozWQCM7fnXWMPDozG4Urh8gHbe/161oSoGR2NbI
         e7nXoLcLIKLETzBZByXcCxc/cqa56m0aYBV7XQAtagciJIMul+LBf0PGLxbU27r7A1h0
         74Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765538716; x=1766143516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEnn545SHxpJYbhpEqJ4kau8ivvtfD9Ghf76lIvPG6E=;
        b=SFprLSf+mGq79ukut137PGGWxtihm3+JpFUfFVQQHYsSm/0hpfqXGAu3U8qtyX1P7s
         uvOtqlL9Pg9WGAyXTBWLIqJ1AdBS4E0NtegIUxWGPvGXaHpJ6Ud4ZhZud35BnLz6c9Dl
         dFUD93GsHe88KZBpc1o/jeQHILq83MtBPEBj4jxjefwf1tooOlKE5iQnsqRVwlOF1zq9
         nOIoUzF98K35v0c7awW4N66es6wtFcOA3wUM0j9fUGRMtIeWpZ4BHSSwA/Bj5Gazy1zD
         RZr9yEXkhmxaVwSGAE1hJWm3In7GgomyBPI5ztj3iODYBoxYmAOiVgPk/GuMI0xKUbAx
         qXaQ==
X-Gm-Message-State: AOJu0YxR+7V/SWIJc9Hiv62+w09BM6bw5wbV2RrV7nsJFiwDtZy/Ecjz
	4ToLhuhC2AxR1eCbCTF3Hj+NCNNRdFNkq9iyp1a2i9G3/FFW+Ey8T1pGXLKJhgBn3NipPgj1jt8
	0Hp06
X-Gm-Gg: AY/fxX411LssY048pDhqGmTSEE9b/E0v0cRA1Wi2dHqzJ2mICg97dvle5FI9Q+QbbTX
	1VHujRmYkIxIZ0W0/GTWzUXt2LSZ4ViYEX/uhk9L0vDkbH1k/0xqiXyZYcMn13/ym1KdrP0DEPA
	f5vo/HsCpv5z1FeYSdTQVfBEU62q8COGNF1Juq3NV9Hyrlr6+FvQbCdJkear/HjiGEcr0CtiJVu
	44O/gzoS600IRCLXl/gwASudicDr1bcfU2naIvCXMBQfoYcKMx1wxI5M3f/nzxAkITLClZz1b5E
	ypw1unKHpsECdVY08X8R8Deg5jDtMeGpVYaEUg75ABE21n8aX2SStsap6jMLDhUhc5J/wm07ZCd
	iKaZurOiQiVIskWuhkHYspVEpn/LT8lr+qFu3jg2NUIdq9u4ID3bHEMkReaSZeUuFMfoUiiq5aO
	wC6wdHMRyiPzWxwGnVE1duK9c=
X-Google-Smtp-Source: AGHT+IHkaay9CDV5kfE74IqgXxI+GzQAfyiag1hnUiI3Kv6EDGuWkv0C2Lwzh9GBMI+h6MNTm6fuig==
X-Received: by 2002:a05:6000:2c09:b0:42b:5406:f289 with SMTP id ffacd0b85a97d-42fb44a24f0mr1717666f8f.3.1765538715596;
        Fri, 12 Dec 2025 03:25:15 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a66761sm11462241f8f.3.2025.12.12.03.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 03:25:15 -0800 (PST)
Date: Fri, 12 Dec 2025 12:25:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Richard Cochran <richardcochran@gmail.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Simon Horman <horms@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC net-next 02/13] dpll: Allow registering pin with
 firmware node
Message-ID: <ahyyksqki6bas5rqngd735k4fmoeaj7l2a7lazm43ky3lj6ero@567g2ijcpekp>
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211194756.234043-3-ivecera@redhat.com>

Thu, Dec 11, 2025 at 08:47:45PM +0100, ivecera@redhat.com wrote:

[..]

>@@ -559,7 +563,8 @@ EXPORT_SYMBOL(dpll_netdev_pin_clear);
>  */
> struct dpll_pin *
> dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>-	     const struct dpll_pin_properties *prop)
>+	     const struct dpll_pin_properties *prop,
>+	     struct fwnode_handle *fwnode)
> {
> 	struct dpll_pin *pos, *ret = NULL;
> 	unsigned long i;
>@@ -568,14 +573,15 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
> 	xa_for_each(&dpll_pin_xa, i, pos) {
> 		if (pos->clock_id == clock_id &&
> 		    pos->pin_idx == pin_idx &&
>-		    pos->module == module) {
>+		    pos->module == module &&
>+		    pos->fwnode == fwnode) {

Is fwnode part of the key? Doesn't look to me like that. Then you can
have a simple helper to set fwnode on struct dpll_pin *, and leave
dpll_pin_get() out of this, no?


> 			ret = pos;
> 			refcount_inc(&ret->refcount);
> 			break;
> 		}

[..]

