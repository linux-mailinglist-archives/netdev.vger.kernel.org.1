Return-Path: <netdev+bounces-103955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74B390A855
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 10:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F471F22DC8
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E80190462;
	Mon, 17 Jun 2024 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1mUa3Yl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE919005C;
	Mon, 17 Jun 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718612726; cv=none; b=nbw/Bc9+i3uNTG6D+I6xPsYiaDI5i4AJkmcbNUgihi+73/KmKQMsUB0Ygk7ZwfV/GsLoMGcIo3rQISJrvrIqwd4RQqtd3/gmBeNOmgCncNoKpUhcwzslwpxAs5a8zvQjVrvkqXPflyU9FIKBDR4XVZH5+W39BJqgKy3RiL02JVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718612726; c=relaxed/simple;
	bh=q+ykIq3JrthTza0nnbx3+H/W4+2t2m1QN/3JLPVTJbo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=i8DSaTJnhwMwuG772U5P5/lMiGzPWafRCPVYs7xwwmZvl2mGVHVuBX5MuXzeB64dyOoT23XRTbcUPv/eq5pAtFHZuTx/tMFYH9+pcczV4rNp0ecWQGkjVtJP3AgzC4gGR1DJVevkR8KRcOQ2RSpkDzygsR5d8j24m4SUsNqA8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1mUa3Yl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36084187525so1817646f8f.3;
        Mon, 17 Jun 2024 01:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718612723; x=1719217523; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wTj9FCeMEMsqbwW0LLZPKSs2YM2K1G3AwyQg5n+snzc=;
        b=L1mUa3YlbrtEUqDHoebMP37EEHgWDKpMJuBvdpy7fzqEP2yZct+j3E54d4lksnCKRl
         ylKdxeGuPxD+cm8lwhEJdSWRcwDlHjeK5d3i1i/W7cdN3EsPeki0atf7Dl2d5ceT4cKI
         f95JPRNk1sI4NKPya+GYPytjyD5QxUG+KOifAL+ZQq2pQvgw9p2MA0jSnUFZoiZDgd/v
         qRQP/khM0HLfkKgc0lEMQxhI1SC0qsECMPJVVQbIZnzgi5DOxxaEstr8S7Oeyz7ILshT
         uiqvJaiSmJtm+oWrXBj+tuit9s+eH6rxk+n8oooxU0Qj+Kmf+suoiJzsJTgZcivFbsLj
         /tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718612723; x=1719217523;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTj9FCeMEMsqbwW0LLZPKSs2YM2K1G3AwyQg5n+snzc=;
        b=MaJmCDu1065/V5JtZ60vCn1J5ceTe1PKHMEibI1iiCn7QUJ2s58FjFj+F99w0wC21+
         9gLJQQ1Yi3mYguMIweIyljGnZeYmyqkJ66TqJpwJkCnpD7eZzh2qu1f3EBuxxqXHiOIK
         UIttbhzUuULBp5aiN+38SKI8W/J8txDYuJgRwxnMiPWw1pOav+CE2Rv5dO3UgOu74Q+U
         gM8+QzAnBpxZNxIypygMMoG//xir6FBKGy3wt1UtEnzpHzQ4XTqTW6h+SAFWHM3/aU60
         Ig2fDzAGhx27sSl+8gAnW1htwm2vLeW9vspRWbseZdbu5N9/Zs3B4yTlthgm0mBifNLs
         Odeg==
X-Forwarded-Encrypted: i=1; AJvYcCVrgnFBA8ue3bNu2RVY7Vup+U1zGEVo+NZeytawKDFGlkgthA4NdpBS1hi/R7XSn4sC3sP5FuNijPxT2oKPJmg9mFS1mVlmkxKTrpUNNYhlY4s2kUfNTx/gjgsmBWuc0hYqyebv
X-Gm-Message-State: AOJu0Yy73/+JpUpDSLt4Lxqo64DgwS6eLQH/7dmymfIlUeUlUq02CeEx
	8bQ7R9/6ZjO0TWKAfCkQmUd9Q52/rIlt2NToTOls3IGMB3MN1160
X-Google-Smtp-Source: AGHT+IFt4JX3Jbfuc0eYBurcj5EoAHcJCyOCK8+9XhLyCVo6x6fZnIYeDbKcVH2naa3emRECXqY0eA==
X-Received: by 2002:a5d:61c3:0:b0:360:9533:c716 with SMTP id ffacd0b85a97d-3609533c932mr1652408f8f.2.1718612722567;
        Mon, 17 Jun 2024 01:25:22 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:9594:d2ff:a13c:2a33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093499sm11532931f8f.8.2024.06.17.01.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 01:25:21 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Oleksij Rempel <o.rempel@pengutronix.de>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  Dent Project <dentproject@linuxfoundation.org>,
  kernel@pengutronix.de
Subject: Re: [PATCH net-next v3 2/7] netlink: specs: Expand the PSE netlink
 command with C33 new features
In-Reply-To: <20240614-feature_poe_power_cap-v3-2-a26784e78311@bootlin.com>
	(Kory Maincent's message of "Fri, 14 Jun 2024 16:33:18 +0200")
Date: Mon, 17 Jun 2024 09:01:28 +0100
Message-ID: <m2frtc9ew7.fsf@gmail.com>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
	<20240614-feature_poe_power_cap-v3-2-a26784e78311@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kory Maincent <kory.maincent@bootlin.com> writes:

> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 00dc61358be8..0ff27319856c 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -20,6 +20,20 @@ definitions:
>      name: header-flags
>      type: flags
>      entries: [ compact-bitsets, omit-reply, stats ]
> +  -
> +    name: c33-pse-ext-state
> +    enum-name:
> +    type: enum
> +    entries: [ none,
> +               ethtool_c33_pse_ext_state_class_num_events,
> +               ethtool_c33_pse_ext_state_error_condition,
> +               ethtool_c33_pse_ext_state_mr_pse_enable,
> +               ethtool_c33_pse_ext_state_option_detect_ted,
> +               ethtool_c33_pse_ext_state_option_vport_lim,
> +               ethtool_c33_pse_ext_state_ovld_detected,
> +               ethtool_c33_pse_ext_state_pd_dll_power_type,
> +               ethtool_c33_pse_ext_state_power_not_available,
> +               ethtool_c33_pse_ext_state_short_detected ]

It looks like this should use name-prefix: ethtool-c33-pse-ext-state- so
that all the entries can be shortened.

The entries should be in hyphen-case, not snake_case.

The preferred format for a list that spills over many lines is to use
the yaml list format:

    entries:
      - none
      - class-num-events
      - error-condition
      - mr-pse-enable
      ...

Thanks!
--
Donald Hunter.

