Return-Path: <netdev+bounces-229943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F55BE252F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840374251E5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45246235BE2;
	Thu, 16 Oct 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AraXTbuz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB63254BC
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606216; cv=none; b=RBTY6zT/MraQwk/FndWCej+sDE53GU1VlLgecZ/l79jfDNTQsxouHN9vOoioemXoOa+5tIYj2RR8g3WEX5z8wHy6WXRDdWeluQWrRVcahWUGC/zUOfqlWanVy1ygp2unVm3hNXL2ZlrQEmmFal5vPeLhKV83GD/Fok1O4rxh4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606216; c=relaxed/simple;
	bh=CXV1oo6crqea4tYT7OPZhTATlmitji7rLfQtzBOyCeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUMCgyYJIXQZaKNgNhYdOEHqa3LRdbvDiI5eq+9q+SBQpYfL3RoltZrnEq6KtTyBm92pKjacwnyV8iMtkDIPuf7J/7HeciVdVQUaNBBtKrQcagM9KXqJmNG2snr8Au8MI1FuN6p81dIznCvcytAZOcavGg4DREu+wFKw2xNAC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AraXTbuz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so5248955e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 02:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760606212; x=1761211012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOQm7CalEqLSZ8sLsEYQvVVuablwwCJXJ39S/7as4zI=;
        b=AraXTbuz0I0yk4YQiBMGCCUcgR2GSQRn2+tMexHI7SqMGbm7c36Nt2Fe/m1jYkv7CV
         KgxxNwT6vfj7ybQRguz0r5blgCsaFarmKnTxU+RdGssVWcVzl+7MFgjNEQT0W8Mjl7mX
         2YgPp0/OHs2CI4PMYjfd4FUHm2eW/qaOAIpRBuw8ozT5qql8cFlwyfcCe2C+/lPatVp1
         TBPvkn1YcmK64BW4MXEtrDwW43HSBC5sxlzkWQGFCpw7JnmT/CEP3eMTQXUipDqPAd6w
         iYFbghXphSEwzASN4cNW7nbxfws/CDwCKvRrDORAnthRDE47rEZuhwR8n02bA4vyxBZT
         fgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606212; x=1761211012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOQm7CalEqLSZ8sLsEYQvVVuablwwCJXJ39S/7as4zI=;
        b=UYedo6PRLixYAG511p1IqjLqfktyPzaPOAq6apXknaPOTT9z6JjNsmKa7MAjtFo8SS
         hi0MxyUoce3twLxrxCGpUW2qPz3G8gkYoATNsezCtz+7+G/yds3q17ecZPBoPGjInXnT
         g0gZt9257+lQUq22nmG/UuuwySt0RhV+spQui5kZN/xNNcjmdXvDfmHwXYPPt4Ngghwx
         Jk49/GBg/tgonnyIg/ubDnmUTsuAZV+s/ppa4twCoRrtxn3HyARDW/L5PnNkaqcplzPD
         KO6k9u1xnuVnc/uzIDV1YREbPoy+qP0jscJ3zrT0edKFpe8/OcKRJkryq6qWrHQnJ4yt
         Ow8A==
X-Forwarded-Encrypted: i=1; AJvYcCU6zHpo48KO7o0E2SxR5ktRq69QU16jJyaMjHhVIcjmpOgR7LLkIafwjmx/jhfEW5eV44lJNik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wMACDv7rfx+yahFbz9aK13fuJ/W4yVrhZAHj1rO2nnsP2xFN
	3THB49POGImxfTW1AiGlF1cn+C9pFyzWJgrI3/hx7ysuEXllytFKXQvdZo4zEvEszMq7NgVqGte
	LbBU5XpV+ZA==
X-Gm-Gg: ASbGnctqNaZj+mvStNAoPuwVNTVQtx5mmfoHoCAXR3CTFRHplNfeiDra+3sWwg0j6Oo
	/oJrtpE78m39AJ5JLWMfECiM9KEG9PKB8o7LrAxSHGiAC6dUNnGdQ/4STz2l1YQLTQICbTzpX0E
	L5VeNddYw35R8NMstxqI6/pFcFliqagGDGvK+lT88W9YNxSi5l99oek65uxw2KBpby/MYmPtV2r
	ZxB/05dsioQM4rWLcnd62T70uup+Yd9xTKUuxmNdTxozTi8/Z2ip/HUgilxdGRdEmWB2XI31zUe
	nqK5DgTayhKopTalGJYtpXUcEXWB+yEiEP705hUKPuFW8EIR3Sfm54hRKYT8Qu+B1t3QZB2TnwK
	qdtcXsX2WlX+zpAGm+VmnRnhGvNSeNdNmG9P6TgUJO4Pb56eREsrZbMVXo/OwiQ0Zd3me2A15El
	YoT2bmDfqiEt+/DB2nDQS5C2aX2hc=
X-Google-Smtp-Source: AGHT+IHNbK3Ki89HwpE87g85l9ngMPvW1ZgOuAXmQgBeq+a/VnNNfoTGlzyHQvi3Z32vF2/pvxhiPg==
X-Received: by 2002:a05:6000:26c2:b0:3e1:9b75:f0b8 with SMTP id ffacd0b85a97d-4266e8dc01amr21360118f8f.47.1760606211546;
        Thu, 16 Oct 2025 02:16:51 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426fc54b32dsm3879000f8f.30.2025.10.16.02.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:16:51 -0700 (PDT)
Date: Thu, 16 Oct 2025 11:16:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com, Parav Pandit <parav@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next 1/3] devlink: Introduce devlink eswitch state
Message-ID: <6uzvaczuh6vpflpwnyknmq32ogcw52u35djzab7yd7jlgwasdc@paq2c2yznfti>
References: <20251016013618.2030940-1-saeed@kernel.org>
 <20251016013618.2030940-2-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016013618.2030940-2-saeed@kernel.org>

Thu, Oct 16, 2025 at 03:36:16AM +0200, saeed@kernel.org wrote:
>From: Parav Pandit <parav@nvidia.com>

[...]


>@@ -722,6 +734,24 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
> 			return err;
> 	}
> 
>+	state = DEVLINK_ESWITCH_STATE_ACTIVE;
>+	if (info->attrs[DEVLINK_ATTR_ESWITCH_STATE]) {
>+		if (!ops->eswitch_state_set)
>+			return -EOPNOTSUPP;
>+		state = nla_get_u8(info->attrs[DEVLINK_ATTR_ESWITCH_STATE]);
>+	}
>+	/* If user did not supply the state attribute, the default is
>+	 * active state. If the state was not explicitly set, set the default
>+	 * state for drivers that support eswitch state.
>+	 * Keep this after mode-set as state handling can be dependent on
>+	 * the eswitch mode.
>+	 */
>+	if (ops->eswitch_state_set) {
>+		err = ops->eswitch_state_set(devlink, state, info->extack);

Calling state_set() upon every DEVLINK_CMD_ESWITCH_SET call,
even if STATE attr is not present, is plain wrong. Don't do it.
I don't really understand why you do so.


>+		if (err)
>+			return err;
>+	}
>+
> 	if (info->attrs[DEVLINK_ATTR_ESWITCH_INLINE_MODE]) {
> 		if (!ops->eswitch_inline_mode_set)
> 			return -EOPNOTSUPP;

[...]

