Return-Path: <netdev+bounces-65165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D46C839628
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E607B1F2662E
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9831B7FBB0;
	Tue, 23 Jan 2024 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0JoMSo2Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C57F7D5
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030295; cv=none; b=WKJP4wDRmZSmQzgxMtfrEw0q8hB+46FnVr8JPqaePQxlThk0UcnKL4hRlJzGsjOSoYY9GhF1dWDwpLbT9nlXLubmbf9Lsknwk/BOUDEWGoZ6FbLwj9bh5W7hJecWhvNXOzKRO/FUg+MAs47BmWXVnHR1uOlhotj1eX33LsHdda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030295; c=relaxed/simple;
	bh=dpdN1sRt1Y75gMNm+EJr6b3okTse4fnzbjfVdyMBSBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFIINHOiVNYra/sP/+ho5P7joRHTP5SxmBui40vJSiy3f7pQBH9NWIjI+Qc5p/NxiC1sNNiOO06F92YiRcCGNE4uwbTN0RVHN8pfmXwL9oMj5rGqYWd+n69sPnfUMfY7DRSVaO6+Lk5jKDbAHeQAbc3fwvu3qMhlUT3f0tKaQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0JoMSo2Z; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so3897848a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 09:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706030293; x=1706635093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NWcZ29gz+8EHdDIhgC7r20M1HIWEh2Wi6Ogiqhyn3I=;
        b=0JoMSo2Zr7cw2Cba4DxgZyZ4qUujan79oEUcScvK6cDlNBrN7PVWlxGl419zGeZpFm
         o/s+CGKDzowDlV6IpwCJxpk71JP/f4IuFc1H9E0wxh3ITSvDVz+WbFZLEajcGqc9bB4x
         Q8mBMZa8O8zuSmzUKVbVNWGFY1eLfStGUli83QkRUfakUdw5TzIu3A9rz/mfctmDVbon
         76HqI6AFgTrmFWnfRZjhXtZ5ohbkk6iAm1APQq5u9B/m9JeNSDLTDR3V7NCE3ugp2pPs
         Z/TVt8JVPtm2jF8NSarSwmZ3exQmC5eV2cg03/Fwu3+hLuUblQDaJyxp5ZDy9gDT/5Vn
         S3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706030293; x=1706635093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NWcZ29gz+8EHdDIhgC7r20M1HIWEh2Wi6Ogiqhyn3I=;
        b=JWE6ErSPwHOtA/y6/SHvvPbIb0mLfWRf0JQ/Rpr+NfYk3ZkFxdViX+Ej5kjjPGXyMR
         Byo+7TgW2WSe9+rc3j7z+8elMOxgcU2QTEa1DYeZwxt8mAbLIBty2X/jux4gemOdlpvn
         FFf2Zmi6C7yQB7psyQsSQWyxlet9tvvmKzF2o+WGUK8KqzBup2zSi5jgVkOd6l/SFiLz
         IAb5aaPZF/+1ygOvBWzNbYIOj4MG6dTW03gZZeNtpHfEb3/LLYniebJlU0b05+Jagequ
         Y05/6kIXO7R1PSKJ6uh31yCaT6uQ9iwE/JvhYrpbUq80R0+IQt5AVYFb7kNxhKrEi5J6
         JOnA==
X-Gm-Message-State: AOJu0YyUrIYiYIFAIgqwXQWD26EWIBmygfTtc3ydWBE171D8dr4soT/s
	Ci9WbwIBwLUuS2dXnmLsJ2/01MXGoSNjDdGb06gbWbbCAGZZ309/cZJZlHvic44=
X-Google-Smtp-Source: AGHT+IGUCUNz5GNEUoPd6YKA3WVcxLksifD378GqQY1EyHmbAv5TzujzBSwVb5V8CSrSB+4dygdROQ==
X-Received: by 2002:a05:6a20:7f86:b0:19a:3a41:fddc with SMTP id d6-20020a056a207f8600b0019a3a41fddcmr7500147pzj.8.1706030293377;
        Tue, 23 Jan 2024 09:18:13 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id i2-20020aa79082000000b006dbe6eb6495sm3492987pfa.94.2024.01.23.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:18:13 -0800 (PST)
Date: Tue, 23 Jan 2024 09:18:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH iproute2-next] m_mirred: Allow mirred to block
Message-ID: <20240123091811.298e3cb5@hermes.local>
In-Reply-To: <20240123161115.69729-1-victor@mojatatu.com>
References: <20240123161115.69729-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 13:11:15 -0300
Victor Nogueira <victor@mojatatu.com> wrote:

> +		print_string(PRINT_ANY, "to_dev", " to device %s)", dev);

Suggestion for future.
Use colorized device name here.
		print_color_string(PRINT_ANY, COLOR_IFNAME, "to_dev", " to device %s)", dev);

