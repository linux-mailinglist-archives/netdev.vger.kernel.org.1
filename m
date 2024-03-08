Return-Path: <netdev+bounces-78879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED8A876D5F
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 23:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A6B282957
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A3736AF8;
	Fri,  8 Mar 2024 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="scnXPPdD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9B22F11
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709938664; cv=none; b=obSXLRjhM3u/1+KK6yH4EsImJepg7HBMSATKfAqzVQnfyTPbutCwcZghIW9IZJcXi82FMZmytyO7vY90Qce0c28VV6XqxxXTn7iP/NN9966mMAOotKxnnnoM/iBLxByvYZQKn60c3rkPKOwTri7PJhmhfKWlACk+jCFneDWqFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709938664; c=relaxed/simple;
	bh=BAbB3DRmL6hsCe/txTfYZsaJdd+MPp3/ItA26KH86L8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+26IU0suaWN6hBG1LSp4FqzsFAtEjltgKPbE0mkzTsfShjFIJacLVMeBto747GB7ojM6nCstblTqqPU9Ltr4GM4+rzkS0fUy8furu+KbnacxDi525LUl+OEtEfhO5gDSNbPmHi+ypFHDOCwik+xiJQqCRshibBJxWnVjm8Hw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=scnXPPdD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc29f1956cso9443815ad.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 14:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709938662; x=1710543462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pE2vs9yV/h7ADgFviHJbmCYlfLUVmLQJJ6cEz+hKXb4=;
        b=scnXPPdDba2PvVzGnRDD7DCE6lJvLzZW/GfxRTD0sZj+o5LL8k0Zfg3S2cj0yjqFYU
         sTTup/2FE4aS7RGq+R1hLjBcuQG4vsqzO5t9EvaCTbDpPivgkX++KA+bBjC6HpXiuvY/
         HYVMmwVOixnDuzmdUs4gDPR+gLgvJOcwMWGaddj2s9SwMJi3PZnii+QoCBpMFwTy/Pr+
         ek6egXn21pX4nsMaDSHyC7OaoBiiaeVKSIaz6OR3+xbWRW7/HiyfGJOlUU7WxZKGSSDn
         PLY679ezG2XtnNaGArYfWaqt7dsC9Ue5IGTR6hPhcKysuO8+CHrwT+S5r2kmQIKlOhdI
         ZAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709938662; x=1710543462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pE2vs9yV/h7ADgFviHJbmCYlfLUVmLQJJ6cEz+hKXb4=;
        b=eJYJP3TAKrT82AcT9foT2vzBqUGV5EgtDIf1hpsNb9igPc8wTUpV32x0EBFfOUjf3V
         1aWQJzO/xV7TwByqIJz+7lYq+aKXnuVrCVdrfRKXDaNAM+2TxgJSgI9bDDjHKFnDwezo
         6Bge8e8UeamjE1Q+oBf1dkd+fwQbtO1+RiRYdrK4pqD9SN8Yv6u7VFCt39HsJjbviCaY
         ek/d+vHtNmiqHMi435n39H1sQYY9+NIgyXYRhWGn2JZPrbamgSyX6tbpbh8ruISYfRaO
         b2XD2c99HsVAdtSMrTrGUrJdASaJCPCnPKOpT+ipqm6MZ7KCXbG24P4zkzHxcgffqFap
         jz6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNhYj7id6ZdnI7jeNn8iBt3GsVyfAHIZDDdd/1IdfeOR7ERjS7GWu1UY94SjiynWIf4hVGMDrOOa1ZqbofV29LfL7BUOCR
X-Gm-Message-State: AOJu0YzPn0YIk+GxLy1Gu6XaX48xAxuNbRpeUh6joxJsBuVssLRc4Z+j
	TOEoMLdisXqZlOxOlm7D0kaZZ46jastZCKjIzovLRzGPflHShhLj10d2zpwMArY=
X-Google-Smtp-Source: AGHT+IHQ8K41FYwbJnyqHCST4m1T0+WIuS/ZkL3flLf0Byg5+ldlK7TF+ps37JYsqljr+SejwLZFEA==
X-Received: by 2002:a17:902:ce12:b0:1dd:5a09:1164 with SMTP id k18-20020a170902ce1200b001dd5a091164mr98603plg.38.1709938661739;
        Fri, 08 Mar 2024 14:57:41 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id mm16-20020a1709030a1000b001dcc97aa8fasm163856plb.17.2024.03.08.14.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:57:41 -0800 (PST)
Date: Fri, 8 Mar 2024 14:57:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, <netdev@vger.kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH iproute2-next 2/4] ip: ipnexthop: Support dumping next
 hop group stats
Message-ID: <20240308145739.0eb50132@hermes.local>
In-Reply-To: <d28e3c81f9a6f57efc21c1275d9bbe659ea6abe5.1709934897.git.petrm@nvidia.com>
References: <cover.1709934897.git.petrm@nvidia.com>
	<d28e3c81f9a6f57efc21c1275d9bbe659ea6abe5.1709934897.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 23:29:07 +0100
Petr Machata <petrm@nvidia.com> wrote:

>  
> +static void print_nh_grp_stats(const struct nh_entry *nhe)
> +{
> +	int i;
> +
> +	if (!show_stats)
> +		return;
> +
> +	open_json_array(PRINT_JSON, "group_stats");
> +	print_string(PRINT_FP, NULL, "\n  stats:\n", NULL);

Use print_nl() to handle single line mode.

