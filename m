Return-Path: <netdev+bounces-67866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B35CC845234
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528A51F29D9C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB40C1586FA;
	Thu,  1 Feb 2024 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="a1mCszzK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4EE1586EF
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773527; cv=none; b=bE9Qb9aJuVQCU+bt8Qd/DFNMyEysSUWqYzORZOnydW4tiiDggraC81xbLfKqBZg+yYe2l/jEmU7yVW4t/g2fCWk8w/tP7GUF4+sVi+++4kXud0W4wgYd8Ln5DINOFB7BNk3CHM8YipDqtJRjmEE4HXgJ9K92Ni38Uuczx4vRCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773527; c=relaxed/simple;
	bh=3doOOfTwch96we44aEoN/N+kUin3abrCSam0C+Uo5og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeCbjRNMkAZGVb6SrtamFcEmQ6Kvf3TiGnZqwXFG7aNKUcREeEIQwBdRguP02U/dalGFiBpE4fuBG/Gzd6+tIByCdE40XFEKhwdpJXmTxqtOg1g+Z4lrp9AwFUv+HDI1OLLpQa8HsJPcn+Ayybl1Ad/8Xw+xfjMqWH8+1rplveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=a1mCszzK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ae7ae1c32so367842f8f.3
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 23:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706773524; x=1707378324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEB1jKMD6m3vF3/N1fu5eKuMmW/5Mh94YFllnsy6bK8=;
        b=a1mCszzK2XrgfPHR4r9mR8f5Tl+NKoqPa415aAJVrGFy25n1f4gV7899hmCDRbsoOP
         wwGcRG6mvLd7mHWVOOpDsxYgB+X6RBqQwTurVnV0FLmYaJMM/E1GxhkTPAn+iWdsiGLy
         JE9UK5dZLyz/EmvbwppSslJeyYivZhHBewsYdrRMgvXMOvdcaH0TowoYg/uBdNMNrskW
         N6qppGaAhHSLWy69a61rg42KNfy+N4vSeyYIm6YVlWowv6tFA8gkPnLkqcbVa/7OsbUg
         gAqeIT3mWQioPHH9/0hesRqn4umLQcj4DiseIk3B8ha6DHvHRyKrK9NgHCLuOu1+jGax
         M3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706773524; x=1707378324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEB1jKMD6m3vF3/N1fu5eKuMmW/5Mh94YFllnsy6bK8=;
        b=S80XJ3bXIY1Rh6nayIuHz3brHbuZBdBuTAGLMdkOT4T8Ou5RTO88NcRFYuNyYRQKja
         BvG+9Df+QC39EUy68HBlVNH9Mw9Mp93boQtdoLCe3TtJVYJWWDfzl2+zUflXLJwT4ulw
         dCcBbX4OycKVdH4Wgnw2i0Oxki4zb57N6larZNT89qOijSxcPJFEpPAy7j4DC6WNOyj4
         Ct9sSws7ABIaEGId7UxqaVUZkGBjRjw01u2IZcfCY0sASdOEQ7U10aWv5s870PojBNph
         PzY57z9ac+QfqSG6r/tM59dh5ntFJYaqOLjIdxDIU/x7mITWc8lRadIofR7J9F4iCyzs
         Z0IA==
X-Gm-Message-State: AOJu0YxYF4d1NJqbNefuPlhDTQUBTWJ0MCRZztpgb7VGU8pCnU3z54x/
	cgGUzb+c6DoQ4HEGgE3zIUbELPcaaXi4Eoj8kAHssZ57kA7Z9tyi3wUfr7vMeno=
X-Google-Smtp-Source: AGHT+IEzXnY5g65s5rzpDxqKCORq4oPArdoL9BA0PmQpvUy42l2ZaFRV3D+lBBfzvNNAIB6uL0eSHQ==
X-Received: by 2002:a5d:4809:0:b0:33b:1131:ebfd with SMTP id l9-20020a5d4809000000b0033b1131ebfdmr951503wrq.49.1706773524311;
        Wed, 31 Jan 2024 23:45:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX/NS4sV9Pkx7LYKa6plBta44EGH7iuV15vC3shcj20wTgNgQFW4+vq0Ga5NuTOuhLoxWf5htnOXGQErwCWP7RKlNZnZ26TzBnLTpyvnchwPPyIMjlC/u2EzVdjHzeBsOFJhVsOZzlQcL4J2WSo+9A0/R8RB3cTnVFRrWvflWyld5SmQ350D+GGQRNmeE4C7TXerowGoWnIDei6nufn6wkuqTe/PZ5O+KkSezx2frLGdenNXe1qH04hEOBBKcTTpK06eJHZ37Z6/5bZoafBd85hYg==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t18-20020adfe112000000b0033ade19da41sm14625593wrz.76.2024.01.31.23.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 23:45:23 -0800 (PST)
Date: Thu, 1 Feb 2024 08:45:20 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org, roopa@nvidia.com, razor@blackwall.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH net 1/2] net: switchdev: Add helper to check if an object
 event is pending
Message-ID: <ZbtMEOIDA_6CgRVp@nanopsycho>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-2-tobias@waldekranz.com>
 <ZbpCA3kgoCKsdQ4J@nanopsycho>
 <20240201003305.thoj2y3bjyxq2hlj@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201003305.thoj2y3bjyxq2hlj@skbuf>

Thu, Feb 01, 2024 at 01:33:05AM CET, olteanv@gmail.com wrote:
>On Wed, Jan 31, 2024 at 01:50:11PM +0100, Jiri Pirko wrote:
>> Wed, Jan 31, 2024 at 01:35:43PM CET, tobias@waldekranz.com wrote:
>> >When adding/removing a port to/from a bridge, the port must be brought
>> >up to speed with the current state of the bridge. This is done by
>> >replaying all relevant events, directly to the port in question.
>> 
>> Could you please use the imperative mood in your patch descriptions?
>> That way, it is much easier to understand what is the current state of
>> things and what you are actually changing.
>
>FWIW, the paragraph you've concentrated upon does describe the current
>state of things, not what the patch does; thus it does not need to be in
>the imperative mood.

Well, there is no imperative mood in the next paragraph either :)
Therefore from the patch desctiption pow now clue what the patch is doing.

