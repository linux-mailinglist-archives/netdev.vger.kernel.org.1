Return-Path: <netdev+bounces-80264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6093787DE04
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 16:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A551C20D52
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6472C1C6BE;
	Sun, 17 Mar 2024 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ryYEvo42"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC31BC3E
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710689989; cv=none; b=kaUINhvq4eouvZQmF72Ni5K163BjJTF0BT3iO10R+6SN2tXFJ3qrmV8lJdABOgcp8LFbJg+9pXVtm4yrn8s1RbyS+N1Vs3Dqgi6uvPTeU+PHqGzxeOPkeW0Ixv6ayFLSzZ/SgObpzc0cpBLBiA4vuGacrOl66WvgwIFILXxGgDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710689989; c=relaxed/simple;
	bh=NqMa0AgnUprbpG2R+L+pj7S3f3o3FQhFhzOt3JIo0h8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TH+tQTgCRijz/wYybbsS2EMDgUwrcQ8hHIswDv5F8A5ba7a2uzdWTTVDhowWgMigaHZcbtqWeEv/EpzhYqe+hJ5xM6WJYGEVNaYx397g56AyyyW61axBSDr39inR6pcizsacnyI/uv9rAeUMrQoeMsIrqn38Ok+O3wv1XrA3B2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ryYEvo42; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a46b28a77dso1971553eaf.1
        for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710689986; x=1711294786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLoenuTk1RoT/67ig6QWfH/Z3+Hrd5UZjwRx+S/tIcQ=;
        b=ryYEvo42uPv6h48AatAGZhZqwCo/9jzWm95OvP7/2kpZRywtv4ACNFCRpUjMWj2Wre
         8Ar15I+DuMOvreiUixW2iJQba1Z/dGYsRvOe+RgSepV7wd8L0sixKjkk+0sd0dNwlbT+
         nsolNaq/TxsNvhGyfdTE5TeB2reDMY/ig0qXq0MA/ql0dXJRsp7pvbp+AUMIrrAW8xZw
         HFGiey0xQhFm3i4Y4bxPxC4Z8mM7XaJYcjzG18ZGEQWsSNdvne6+3e7/oXreCIzd10VO
         l9ehlafzcmYgtQVFDS0vWEL6uAYQnXK8G4D5r0bV7cCvqNARjVHh1nHstkO7VHdpUemo
         NagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710689986; x=1711294786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLoenuTk1RoT/67ig6QWfH/Z3+Hrd5UZjwRx+S/tIcQ=;
        b=q8ikEVWZAQygQjDeuE6TSGZ/UAkfxeK6SafHJXVrNj5WO1Ls9FPfPFgwXXJB+PpUmz
         Q1Idx+ZQgOFUuZN6T10Q055bozAu08uZZ3Je0WTsafTCZK7CfqZJ95oB0K7bZYmHTWz/
         nWAlKCF0SeHZv1I7KIHxTacYSXJoA8FIvEFh0k8MkDuasYq71pmL26nVxJTpXOJ+1+tI
         x8vhoNi8BUC8UsmDdn0UV5//WieWfYf6bhVQHzN0PrZ6Ckj6Ut5eKfaR7CoPKwHYgUVl
         vs3pQ8zocU8yfbL/veXbivzy7ARTmYQHqIFlxbUhjBCVoZhS4isyKMlAF8+XDj67LQW5
         uknA==
X-Gm-Message-State: AOJu0YyECuOsPBJOJ2jQUpF7LTIhnJOGOTHo9UQ2UKfF2dXWXqv2ZAEd
	KF7Kly1NzO7ByPrzKEKLpRCw6hybcRxBPgyFEOAm1d5KGt10jSULnYYTLtfOVyDB51+PtIK4tRR
	8VbY=
X-Google-Smtp-Source: AGHT+IGEy7wo3qXs0cjaPIQKZIHAwuvzjj0FV+TE/dXDd+Tv+hjgKi8tuA8ha4lqcqPUlP0KapXphA==
X-Received: by 2002:a05:6358:63a6:b0:17e:bae0:fe8a with SMTP id k38-20020a05635863a600b0017ebae0fe8amr8858155rwh.2.1710689986049;
        Sun, 17 Mar 2024 08:39:46 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id 37-20020a631965000000b005cd8044c6fesm5493634pgz.23.2024.03.17.08.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 08:39:45 -0700 (PDT)
Date: Sun, 17 Mar 2024 08:39:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Max Gautier <mg@max.gautier.name>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next v2] arpd: create /var/lib/arpd on first
 use
Message-ID: <20240317083944.74c53286@hermes.local>
In-Reply-To: <20240317090134.4219-1-mg@max.gautier.name>
References: <20240316091026.11164-1-mg@max.gautier.name>
	<20240317090134.4219-1-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Mar 2024 10:01:24 +0100
Max Gautier <mg@max.gautier.name> wrote:

> +	if (strcmp(default_dbname, dbname) == 0
> +			&& mkdir(ARPDDIR, 0755) != 0
> +			&& errno != EEXIST
> +			) {
> +		perror("create_db_dir");
> +		exit(-1);
> +	}

Please put closing paren on same line after EEXIST

