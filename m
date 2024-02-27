Return-Path: <netdev+bounces-75393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44076869B88
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83431F232D9
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD9D145FF7;
	Tue, 27 Feb 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="e9PyKhjr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEEE535AE
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049893; cv=none; b=HQ6YEa0U6stj9eda9tnwoND9yHaydVcG13h8ezMLiOqHDg+otfKPqTBVz1KdrsPWlpVQCzSTAoOZuHqSwoFvWqv+T5ATrO4gfhY4M4+BsVmOGE/IwSg1bGRLshQ4PSkhJ3JwC1K90R++7V51Ltw+9YlmlxBqP82vJaeQ/e5O6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049893; c=relaxed/simple;
	bh=8kL968OrzTsSh5ut/mY6A73FNCfZeJ1OloqG4AgIX18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9Wok1PhH3Xbj0W3y7XxjlTHbbssYuG/vfJlxRR9iLlLk1rNvvOFEf+EJ4cen4/4PO2bk/SdxSoAibnp/Y3lr7mLycafPpB9SlH8jX6Y8ya730kpU20y0AREk5mGY+/ZBRLlR2LM6D6gPIXT/is2Ww4cxSJfykGhxcCw/bxI1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=e9PyKhjr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33de64c91abso925420f8f.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709049890; x=1709654690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2KSc1kXng4vnsnFRz8+dsnD1ubtZKrqhs97kWLQn+8=;
        b=e9PyKhjr9Vv0aX89k+XwEHzvKRhRM+1Yc5wsXETKbaYG+28T4NfoRNvawxnMCY5ODU
         F3z+1BHLPLdlK9MplnNi3QfGM+Yq9Xg4Udgv8Z44zjM97AJWz5vueckxCs+qjeWtz9vB
         +qi2XnWzJL4eOeHcZi052vbxBeorCRq5g6B97ISAWW0cLim6IBzDEBMcQMswYJqgoYHS
         BQHlwis3KIEBBS72qx9hWRDyPG5/U/0LMb40mFanniFTw1msdbDfYwrSLFmio6cv96u3
         +Y3sL3M6TccqOTrzZZY6vROmiCaEsWGJhvrruvWwxdtjh4HgNHwPUG6XiUrLVZIhaPpB
         d8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049890; x=1709654690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2KSc1kXng4vnsnFRz8+dsnD1ubtZKrqhs97kWLQn+8=;
        b=QgNC9TYtDgnwXrOjm582A6l7jIYZNCWQsFdJ2XvCpBwwKn2yw6L7U6PNqdkXUZ5anp
         xoSCDS0ORW4M0vi46n+eE4+40L8RwmPW9nQ/0E0Rb4F8jMvGoASJ6DxcbnUREPEFyPp5
         EZe2CsLKYYOKQaCEoW8x1S+QK+KnXHnn/czkFH5zLWOKGnVMrAxEjgVyOoU/Nk1gyaUx
         Q3nQVqbm+x4lCU70+G0t3CEM5qjwAkT+S7EnygTgefwuCw+wHlSAgEoahRe4YfZljLP5
         PV41i0UgwSJZkLgTi/odLTrUxWpRk4wdqmDhtb45vBcH6gnHzB6hPWRHuxa65506aiWu
         z8LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqFqThG24ip4bX0Ryt/fhB1j8lrX/1E99QmMFcgsS3oMTJ80MZxyp1/489cpdbqSPnm2lA8MEu2r/OI3/fZTr26ma5nGXz
X-Gm-Message-State: AOJu0YzlNEhjBp7zq6Otn4ivSo4/pHakTHG/Wn5+cb+5/U9X9ioYNnpX
	Pv+No96P++ew+Lp+Krmfm2TXWWSOtDaLUyBHNHEYDkSCE9sgmH5h/bgRysBak0RCknB0kENgVr0
	+
X-Google-Smtp-Source: AGHT+IE7AVJJxuP/gDh319ZarFVTxtj+VRIQ0zC+hJVXEmgo7jSldIgMMYdgKgIzh6lYXxrdjukdMw==
X-Received: by 2002:adf:f390:0:b0:33d:8d44:5c99 with SMTP id m16-20020adff390000000b0033d8d445c99mr8372043wro.1.1709049890446;
        Tue, 27 Feb 2024 08:04:50 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id q17-20020adff951000000b0033dd1a3ed0dsm8096378wrr.97.2024.02.27.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:04:49 -0800 (PST)
Date: Tue, 27 Feb 2024 17:04:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <Zd4IH1XUhC92zaVP@nanopsycho>
References: <20240221153805.20fbaf47@kernel.org>
 <df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
 <20240222150717.627209a9@kernel.org>
 <ZdhpHSWIbcTE-LQh@nanopsycho>
 <20240223062757.788e686d@kernel.org>
 <ZdrpqCF3GWrMpt-t@nanopsycho>
 <20240226183700.226f887d@kernel.org>
 <Zd3S6EXCiiwOCTs8@nanopsycho>
 <10fbc4c8-7901-470b-8d72-678f000b260b@intel.com>
 <327ae9b5-6e7d-4f8b-90b3-ee6f8d164c0d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327ae9b5-6e7d-4f8b-90b3-ee6f8d164c0d@lunn.ch>

Tue, Feb 27, 2024 at 04:41:52PM CET, andrew@lunn.ch wrote:
>> What if it would not be unique, should they then proceed to add generic
>> (other word would be "common") param, and make the other driver/s use
>> it? Without deprecating the old method ofc.
>
>If it is useful, somebody else will copy it and it will become
>common. If nobody copies it, its probably not useful :-)
>
>A lot of what we do in networking comes from standard. Its the
>standards which gives us interoperability. Also, there is the saying,
>form follows function. There are only so many ways you can implement
>the same thing.
>
>Is anybody truly building unique hardware, whos form somehow does not
>follow function and is yet still standards compliant? More likely,
>they are just the first, and others will copy or re-invent it sooner
>or later.

Wait, standard in protocol sense is completely parallel to the hw/fw
implementations. They may be (and in reality they are) a lots of
tunables to tweak specific hw/fw internals. So modern nics are very
unique. Still providing the same inputs and outputs, protocol-wise.


>
>So for me, unique is a pretty high bar to reach.
>
>	Andrew
>	

