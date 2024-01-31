Return-Path: <netdev+bounces-67558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342784409D
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 14:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0A7281555
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 13:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E7B7A716;
	Wed, 31 Jan 2024 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="v20nKiyC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0E7D3EE
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707916; cv=none; b=n4w84DyLIgyQURn6zzDSyqQUp1RXWqUtp4VunKfAIt00T2eXaAhS07pzY90KO8v+fDaM9+oVMF8BN0l4nH5CDVQLCbPgaK5JYb/2rrZTikzaltbSq4VfoUn/IZ0a62+2dXhlRsrjd3GJGBVGjH9UT5k/hPM0bpNHo9VIBNLrceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707916; c=relaxed/simple;
	bh=B5akkCadRMd6543+II2hS0/0ZN2LSIdXzGcCFDHKGko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c+rdOXnCdrn1ujF6rCQ2SHK8DwtawcdEPp5u2648DcemtiPDcy8GomU4U4ID8SZdBy+ltrtZo6SQ0HTR2/eYQIpSoou7Qu2mnB7hCiDENjK4z17PblmEDSZJuMURwfQCeHn0VSbF80aBcX75XSZAnSnSJ3ZvzmdNY7N9RY6j1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=v20nKiyC; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5101cd91017so5771062e87.2
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706707912; x=1707312712; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5akkCadRMd6543+II2hS0/0ZN2LSIdXzGcCFDHKGko=;
        b=v20nKiyCvnHSkBeLeLdi1bRRf6oDM0wGKP4XsEGuuYiDfJAaEZpzXnWw/0f2nbaklM
         g3/EHEPL6yMt/gQcatOVNOs1RV0baCidm4yZKx4WmTu8jy9c9jYwbA/1ZGxKQxoaNM4Q
         9R9kk+1g+4Y8fKtbpyRwi37Zo/8baj2zc4IqB7GVYPwT9EKmrCZ2IfHc4IAIBt6cDxHv
         ACYX48oKOGxbo5jyW/CigXVttQC0tmZB9emJZwq11MKYw7MyhXdb7YZDwNR8XISvYDD4
         5PRTRV5+Rm8NMNeAbtBVb7wWJzYrxvcXFsRnHgETGm8tIa9QWyg+qXSXzkFsVUbEqZIU
         2TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707912; x=1707312712;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5akkCadRMd6543+II2hS0/0ZN2LSIdXzGcCFDHKGko=;
        b=sd/nQXqwcI97ZhyewvFlLeb2WbESmDKrQvECgRjBMIR08kVhu6K2ayFCxpzFjoA7k3
         WuYIbdTz8JXKwyafSYuhF26EmGIoA5fFlh+SHLQwo9ZJkRvbPdIL31xHxyYHGy/2F9D3
         3E7Uh5BBCdXkKT3OMaPUULsq/Cu3kSHRGgfZEqQudCkeCv95VWorDf/8UuSf2cEbGOmS
         4N9EKPa6IiQTotJnqjfcbRFwNKAqwX+KuIMgEK2nxhqUub5HMqIS5GJGPVyjccvYM9FP
         1cXccJI5e4eekNq3Vqkn9AVIk5Fm3cjfbmwKz+Zsp9thwBIAJuQ0nPLpr5BfB8O6dzbG
         CaRQ==
X-Gm-Message-State: AOJu0Yzw8U+XE3khDTdo7aCyVsVVH+sJv5WznO7W328Qj8T7DLUPKzIt
	ekr7acjmhiZ6GOcQaVqrUYsmfCDJpdGefroGN7YWxOYNx6VPjIa9ynKuK72+5HmA0wllH2kBtpc
	1
X-Google-Smtp-Source: AGHT+IFXNOVZCBNi80sdmZ1CnXzKfIZR8B6cTDwHE01kPBqY1xwLRfu/6QACKcnImxj8hEM6UNrpeg==
X-Received: by 2002:a19:7011:0:b0:50e:609c:ab90 with SMTP id h17-20020a197011000000b0050e609cab90mr1152146lfc.32.1706707912421;
        Wed, 31 Jan 2024 05:31:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXCQEZBdGE+kA/EBG6EagF45WN2kE99/U62sVYnOno5Q7EbJGkD++TsrrshIigXpoPecLeshYJ96xqLcqjMnd/YVKqEvUoQ+rvJ3g4WjD46Q2Uy5eUTRvygJY9SQrZtQ4IqVrxKw8LzZ9J2M19EX6fwja4Zf1Ykq346Vaz3/KRVSa2QSsNaKjvup7RkC33tbKRudJG6pcIQNqq2pc0qLILB2XS7vMbXLMOGsEUS1Ct+IE8LF+yAFz4NxhUt48w=
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id w1-20020ac254a1000000b0051129fa324bsm26283lfk.296.2024.01.31.05.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:31:51 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, kuba@kernel.org, olteanv@gmail.com,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH net 1/2] net: switchdev: Add helper to check if an
 object event is pending
In-Reply-To: <ZbpCA3kgoCKsdQ4J@nanopsycho>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-2-tobias@waldekranz.com>
 <ZbpCA3kgoCKsdQ4J@nanopsycho>
Date: Wed, 31 Jan 2024 14:31:50 +0100
Message-ID: <87eddxtyrd.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ons, jan 31, 2024 at 13:50, Jiri Pirko <jiri@resnulli.us> wrote:
> Wed, Jan 31, 2024 at 01:35:43PM CET, tobias@waldekranz.com wrote:
>>When adding/removing a port to/from a bridge, the port must be brought
>>up to speed with the current state of the bridge. This is done by
>>replaying all relevant events, directly to the port in question.
>
> Could you please use the imperative mood in your patch descriptions?
> That way, it is much easier to understand what is the current state of
> things and what you are actually changing.
>
> https://www.kernel.org/doc/html/v6.7/process/submitting-patches.html#describe-your-changes
>
> While at it, could you also fix your cover letter so the reader can
> actually tell what's the current state and what the patchset is doing?

Sure thing. Do you feel that this is enough of an issue that it blocks
you from doing a review of v1, or can I wait for more feedback and bake
it in with other changes?

