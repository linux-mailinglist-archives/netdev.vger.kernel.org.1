Return-Path: <netdev+bounces-157936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B22A0FDF3
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E85E169F56
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0353E21D593;
	Tue, 14 Jan 2025 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IWf92v7S"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D821ADCB;
	Tue, 14 Jan 2025 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817579; cv=none; b=R5OBukE4giWFXo04m7rX9VuSjQBKSoXFrOCDxUDF1CumOeQpeCDZ6fA92FJY14/2k0HBsOFZ9DE/xE52akrukmb2RFU7VHWwl7FGqURqme19X1ztGs+0IOeIdbeFF5k/qDBQ1EsnvJheY0vORDcKUApdPqOgcjNLg7XijygQg2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817579; c=relaxed/simple;
	bh=CnnqqryxM+39efCTqLw0EmM6e9LHBulJkO4gMZo2stM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSAZLgV1BV94WKsRx58l28iKAX2BE11INuvzKBM4tWXUxbc5I57L72Ei173xSM1bUYMK6MjpSNxjrw05uLkRgT+CrSThxQYv7k6O7sbN/BCUxcdlciqYWJdcbdjGBmIUAXmDyKuUgqCPWeUmaowg+1lxOrI3Z+T3T3Q1AyoP9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IWf92v7S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LxnkEuISojLYBheuEd0yDosctCp/cHMUnjSFdb2lCcQ=; b=IWf92v7SDi4hHcwrSDc4P968wb
	y1Q9YWCExvOIG8qTx0vcyDQNIcibeulCP9hzjyaJYQTfUY8agom/VG6tCT0T7MAp1CCX1yAdgliC6
	+TJZGpWmnpXycrdpaAmZrrEn4jdaGGsiQlLBewPTRLDMch+uLsSQwpCFHDqZCkwNTdAk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXVaG-004Hzi-Js; Tue, 14 Jan 2025 02:19:08 +0100
Date: Tue, 14 Jan 2025 02:19:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	kalesh-anakkur.purayil@broadcom.com, linux@roeck-us.net,
	mohsin.bashr@gmail.com, jdelvare@suse.com, horms@kernel.org,
	suhui@nfschina.com, linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev, linux-hwmon@vger.kernel.org,
	sanmanpradhan@meta.com
Subject: Re: [PATCH net-next 2/3] eth: fbnic: hwmon: Add support for reading
 temperature and voltage sensors
Message-ID: <5252ffe7-56a7-4be7-9fdb-6d0b810ebfb5@lunn.ch>
References: <20250114000705.2081288-1-sanman.p211993@gmail.com>
 <20250114000705.2081288-3-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114000705.2081288-3-sanman.p211993@gmail.com>

> @@ -50,6 +50,10 @@ struct fbnic_fw_completion {
>  	struct kref ref_count;
>  	int result;
>  	union {
> +		struct {
> +			s32 millivolts;
> +			s32 millidegrees;
> +		} tsene;
>  	} u;
>  };

Why have a union which only has one member?

	Andrew

