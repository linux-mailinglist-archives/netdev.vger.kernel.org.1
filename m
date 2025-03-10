Return-Path: <netdev+bounces-173521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C92A59426
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC95C1881E00
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A4022577C;
	Mon, 10 Mar 2025 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SDamcEb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5922423E
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609445; cv=none; b=U5J8UgxKyMcLze7dMZ9QxDd/tqXAsc8RdwbVIgY6riZymkHxbSkE6lBAWsa0p1mdEYBux3HErSS1I2MOE2qnNiOLfPemfLDOlbqwxZgM2A0RsX1DxAihY8hJsMaYLQNYW02e6cg9cG2d8LpXpEtYzzSTblpMUhzy0X9UT3n2c6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609445; c=relaxed/simple;
	bh=oGOK9EiI3o8ci/BwbQ8i0AQPNok/S3nJiHarCLAAfsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLglHrVMVClJRKSDox2gKOovaeRJd2n9/W5adfyLn4vh8OyERPC+o8VdXKMZE+2tYmzJludOxLR3jDQl7ka9V6yJ/z+8Rz2GwpwBAKxUQID0ZjbXVDPPETX8r/LRKLTiAWF3dae5YoITC2YOY70UCStntUb6vjk/gm4vtPkl32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SDamcEb6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso8316295e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741609442; x=1742214242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+WnE/5imR3di2EhHXu2vvarTCh376TFcJuzOP6ZCQZg=;
        b=SDamcEb6vH76sHB9d0aRU8sCVgjYR3yZsuZkPhItu8B45MGhKg3QQfhel8rg3XB596
         5mb/iifc+8DiJEJwlQsbvHoD9tHU2SvdQupmT1yh/76OZ4zFgufac2iSnrzkMTqsXEHe
         M6PhoQqr+bXVoUDl3s0Sln/HmLSeDsL7WzebgNgg16dPzr39lcpX4WV/5SsDMlT289Yf
         DeUm6EL2Pm+Bgum80PS1PJK+fE8Slmng6heyDy+xR7kkaVwFTWbteVXlbfsUXrfuP8rP
         Ag3YfTwuB01mflEhshynPFWg3YVE3L8vEpJHSCRLOqS2qiEtP1SpdhQ+36LrOY3v771M
         WQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741609442; x=1742214242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WnE/5imR3di2EhHXu2vvarTCh376TFcJuzOP6ZCQZg=;
        b=ZeK2RiV3DcTRrMV/DAkXbiGC3dNgMGMxioxokekwsWNNFhyRcx3s+Ac5sKafZxIbiX
         I3oL+1cpACOytE4w+ocyH8OpdJq0JnYv80cUGlW7fq3sTCAjqO7CcB+cronqJ9Dth0hH
         2umalFOye2M1JwVTVtZfdyyunwzntr0KCax+1fdlS2W6la4Z8sn7BvjP0A3kFrRnLQDB
         o5LiIB8LV5CCy2EL6qiqnHk8cjiYBe2CeteLA8EsItABPzkLwtDnTUDUf9paN5bNeFd0
         l7xb86YigZi+y0SxgjdonwjhN+6lhNPfKnv09/v2mOWTdShDFvvnrqaveJ5A28u7GMOA
         lH2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXxb8CBLMsNRPU4vK3Hv9geKht8dMmBzT7iEqicPfTkEsQxtQFoNYZkJqGDjFJvAol0FY3LnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy06+b1dS5v6ESOixXX2nfjM6a5mdtR66X82LrxKKqnjRwdT3ve
	+440hjqE9awmhb/P9M+fzu205csa2606M2/ZMwv18AaALUlAutkU9gVvE4aecT8=
X-Gm-Gg: ASbGncuq4Jk0RnLxAj9+gL9N9nCFyjmxoUjwniarmAfEVWu5zBEEAOUX8L7EjbB0SPD
	VSWUAraDjFmcoSBpRlwThtaaatjLgT4sQtfmnxs5rwjw6nzzDOX7kfxNJnZRSe8Rf8CDQGVb/cX
	iJ5jIsCccu6Uaq3u91RB0rKHbNQ6SIw1F/kgvFu2cSn/bjQ9/kv5z6CiNaGEqMyw/OCeI5cIymB
	38Yz9+u3kkaNWApGsVh780WGtkHAt2pyD7dQtLDlAiYYpD9XlWPDEgBMNscDevpG/Lp1SeGPNYR
	VUKpLkQHIcfMywZlzp4umZbLzTHhmYYXm/b83hcb6ZmD+ClDBZpV0R9v1xKoCI+W7rOPhwI=
X-Google-Smtp-Source: AGHT+IGRKo1cJ5t/lY2j0asL2oDJUhmmPtQ93rExpKoeHtpvDFrye3av9IJEnTSX2X6c/6O1HvKm5Q==
X-Received: by 2002:a05:600c:350f:b0:43c:f3e4:d6f6 with SMTP id 5b1f17b1804b1-43cf3e4da0bmr31246285e9.31.1741609442303;
        Mon, 10 Mar 2025 05:24:02 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b04edsm141642335e9.1.2025.03.10.05.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:24:01 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:23:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E" <jacob.e.keller@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
	"Kolacinski, Karol" <karol.kolacinski@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, 
	"Schmidt, Michal" <mschmidt@redhat.com>
Subject: Re: [PATCH iwl-next] ice: use DSN instead of PCI BDF for ice_adapter
 index
Message-ID: <ogvnbkqy73hjndtr7ncmuzw7ai2w35w2osaadb2w4sel3pyrry@yqk3csgruxth>
References: <20250306211159.3697-2-przemyslaw.kitszel@intel.com>
 <pcmfqg3b5wg4cyzzjrpw23c6dwan62567vakbgnmto3khbwysk@dloxz3hqifdf>
 <MW3PR11MB4681A62C71659C430281A15680D52@MW3PR11MB4681.namprd11.prod.outlook.com>
 <144fbab5-0cd6-478a-9500-838cd6303a73@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <144fbab5-0cd6-478a-9500-838cd6303a73@intel.com>

Mon, Mar 10, 2025 at 09:40:16AM +0100, przemyslaw.kitszel@intel.com wrote:
>> Subject: Re: [PATCH iwl-next] ice: use DSN instead of PCI BDF for ice_adapter index
>
>regarding -net vs -next, no one have complained that this bug hurts

Wait, so we are now waiting for someone to hit the bug and complain,
before we do fix? Does not make any sense to me.


>
>> > +	return (unsigned long)pci_get_dsn(pdev);
>> 
>> > How do you ensure there is no xarray index collision then you cut the number like this?
>
>The reduction occurs only on "32b" systems, which are unlikely to have
>this device. And any mixing of the upper and lower 4B part still could
>collide.

Passtrough to 32 bit qemu machine? Even how unlikely is that, you are
risking a user to hit a bug for newly introduced code without good
reason. Why?


>
>> 
>> It is also probably necessary to check if all devices supported by the driver have DSN capability enabled.
>
>I will double check on the SoC you have in mind.
>
>> 
>> Regards,
>> Sergey
>

