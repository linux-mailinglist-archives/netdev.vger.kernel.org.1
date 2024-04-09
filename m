Return-Path: <netdev+bounces-86107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F489D94C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF7028466E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4AB1A5A2;
	Tue,  9 Apr 2024 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G72FOvaG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9FC384
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666258; cv=none; b=ND+javpxaQkZtZixRBn6SQHGZkCr3SMrhSmyPlJtWttJ24dZjTcHDQ0PWw2p5+pKEH55FZ0nk00FxC4J0uCYQ+yp2qA9ixAxcriwzU4TBigV1BgOtsq/hrck05Vb/GQg38/KsyxGRk21TxyVpwY6Fpvu+iNYzy6VT3WgyAQqWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666258; c=relaxed/simple;
	bh=Jcc+6oJLK74Cn3vraX6m5D/9bOnxJC8UB2WEUR43lKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN/C1rqRREOjL+jHSho9FZKBp/5wQkn5kwKix0xuGn+EHWklernlSIeEEYSHcJV5b2ORqHeNePOy1XACUSZ861RoFqZ1ObK3E8Kw6d8/dybILP1WsXgJwt59SpIabDCdtkKSwgnm50ncOPhxS1PT5YWPgsSIw09z0E98Z7O6Edw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G72FOvaG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41634598125so23154645e9.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712666255; x=1713271055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Euc7ZactHVEyL9dUfLh5rCNjA8GEVc6sJElHimQcwQ=;
        b=G72FOvaGMu3Qph7J/+0rG/Q0zIOk25mcQ0yrXAovxkbesSTX1dhaLAJfoj6MVJ7tcF
         5Qxl5N2XH1RL/nTbM4UvoBO6tOO8m3Y90hkPxt4pPmXTDjNde4pR5Yo+DBIbzvdUlZf3
         a0ecj2Q5wE9OznTrRs5DfkwKo5tinaqCi+k9ZnJFBVzbiZw0mDkuuI5THKzXPCQli2j0
         dtRhuVc/6Bm6TSbde+mf5CJXHpeJB/cUanN2uMNCbBlWywlWuuty0kP5ixSLu4mPB/5X
         FcKP+szNxVw/qBw4Ynhak+oaBQmFP2wzrMcHRCILzyMhkrXuoUTzOOi8y1xd3X7BbyEB
         goRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712666255; x=1713271055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Euc7ZactHVEyL9dUfLh5rCNjA8GEVc6sJElHimQcwQ=;
        b=Xo3LLBb+IFNXFEe8QnxudTiZw9jS/AjJEUnuKq25e0CuPWLfhLR2LFYZrTd0CItq82
         11r1xOxp2uLxmVQWx7poDjOTvniZ7z12U2Z7Hh+MRbd5KXkEeBEWxzNUHNcdU0pG1EF0
         X7J4hoN9jdgsXwXhZ0RHTQhzXqv2fRV5Uz678oa1OT7oCPiyh/t3FWRmg8cD1rcl4XFs
         IDd3K16/eauUS0vhfJXJegxnCxJ5elOIeKfX3fQguWVF2JlWUVajQtcamrjIk2tCfu9o
         5jtKrUgfZSBpEqbFl91pBzwrP0qoWopb1wLb2+HSlUNGSEGHAzyBgT0SSvY0bySEGzHR
         ag0A==
X-Forwarded-Encrypted: i=1; AJvYcCXgVb8G8GEsQb0H2PGFclzp4CPx//QjwCkUrs8i2JnMpsUGBupN7/NbQHZiK3YwTu5JDg2aiELHav3aig8d0iTk/ur8a+7e
X-Gm-Message-State: AOJu0Yyek9JT9Aj//9+vZXCv0DfdeEkjZr7/fWUTodMr1Nuz/SJ/yXW1
	mUe2WGxtrJvqnaFakFMekj794icKrKvSkJ2B59qTrFJuFMQ8xweTUnxQ755u
X-Google-Smtp-Source: AGHT+IE4MpTpPutOJ5KhrtUXW3Fl32YsbHhtz6g2kM7wM3sOsqm6dPwSkU6Q5dapvKRofnLvYX8Iqg==
X-Received: by 2002:a05:600c:3b88:b0:416:6816:2b40 with SMTP id n8-20020a05600c3b8800b0041668162b40mr4558902wms.28.1712666254501;
        Tue, 09 Apr 2024 05:37:34 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b00415dfa709dasm17242165wmq.15.2024.04.09.05.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:37:33 -0700 (PDT)
Date: Tue, 9 Apr 2024 15:37:31 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Message-ID: <20240409123731.t3stvkcnjnr6mswb@skbuf>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
 <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>

On Mon, Apr 08, 2024 at 12:19:25PM +0100, Russell King (Oracle) wrote:
> +static void dsa_shared_port_link_down(struct dsa_port *dp)
> +{
> +	struct dsa_switch *ds = dp->ds;
> +
> +	if (ds->phylink_mac_ops) {
> +		if (ds->phylink_mac_ops->mac_link_down)
> +			ds->phylink_mac_ops->mac_link_down(&dp->pl_config,
> +							   MLO_AN_FIXED,
> +							   PHY_INTERFACE_MODE_NA);
> +	} else {
> +		if (ds->ops->phylink_mac_link_down)
> +			ds->ops->phylink_mac_link_down(ds, dp->index,
> +				MLO_AN_FIXED, PHY_INTERFACE_MODE_NA);
> +	}
> +}

Please roll this other change into the patch when respinning:

else {
	if { }
}

becomes

else if {}

Also please align the arguments of the phylink_mac_link_down() call with
the open parenthesis.

