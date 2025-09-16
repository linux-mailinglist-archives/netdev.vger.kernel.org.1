Return-Path: <netdev+bounces-223444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E42B5927E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85361BC4C38
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222B329BDB4;
	Tue, 16 Sep 2025 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NROLxOU4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0441283FFB
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015728; cv=none; b=t5se8jViRSmwTNN3BWoBXdOZD4t+rl9Me6jzN/rOo6LXwGHwwrRj6QLNsljgwiIr98Z3/mxNdR3P30gRLbZwHWcr6M2Ns63Q41Lv8S4UyLtF0PeYl4sjoQsNarf+zlw6Q937nXtphJpU5YTZ+86gUAgJrp3vKZOznAmYBCybOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015728; c=relaxed/simple;
	bh=wtSv0L6/GwqZZywYhmXmG694rGZXr5C/8JsbMi/MtQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Amh+JZSk01eviVpiwum+rIGYQvJjT96NTW/brKRu1HUgwARKUQzlegcaNhg4J2XPTaHGOr+UiuEDytwGcbnoVcVuqH5Ig+/U54ytI6r8CRq7ouHfCoY+XDwhDQUEhEak/DutNBP+7pLw7CeFsmmhcoQlJQuoW1ChKg707b980nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NROLxOU4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-336b908cbaaso45808351fa.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758015724; x=1758620524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haBjQsvE5vE3ZaF/RXUldLy+CB1Z0cpROeB+NEV/yO0=;
        b=NROLxOU4z9V4kypeFZVw3XwLvlvgr7633NM1a03un3CtR4lJaMlWQe4MQ9UCfQlvEb
         6ob7dt32cZ4IpbAOwNI4qTzia9lGJazUfcNRQp/OvPUSDu7sGMuWeYcpArVUzIW4p20/
         gKtwWEXsjbsLeP+PHDVCpBxenDK1C/PGey1OlckTGwKYRad5H3S3uYuXCz0vu8CDIW7T
         egPW/KGCxW3n6bStOzn36fCBk211k/YGoekXP8VanV1j1gkifMzn/eUrtagsp5xDC43J
         /jMULwG82ttCurMTfCNleWqTU5QOCkSM5vljU7z/8VsgANXljSZs6vhM5Asl795xTzI1
         suEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015724; x=1758620524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haBjQsvE5vE3ZaF/RXUldLy+CB1Z0cpROeB+NEV/yO0=;
        b=Pwc++CMtYNFbMTC9iJwR8mZz3j349fd9CwppAfbnHUqr1+c/RM4OkEWS5VkAldZYL8
         OLToAD6XJaqgyvkVkLy/s8QfR0BB1DQ1Pe8cVYECzBs1vKWPRnNSbsKJ/xa101nVMXtd
         IxNUCfYLG2aMhgrIx3TWgJyDQX/xecELHOu3+0VLG3KR6oqCu282yncc8DyVVPzTuWjN
         Et/w4aXoXuBFMExU+QQI2GgqytShcaXARIlH7k38Mkvvp1WcQcIjzeQiVQlZ+5k1SbAk
         lQ/mwTPxa2GL+/KhfKiTNFLTyhcX+k4pEJ015xSpGqArchqq9HW4Tu0LPAym4RgglTlF
         HQQw==
X-Forwarded-Encrypted: i=1; AJvYcCVkHoTsI+Lh6jF9tSZUoBa3ZA4v2lpArfogIT27zXOJGMD9YgP6UwiQATJC9XhrC3/qLTF3aog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qmEyqtzL+k00IKJ0Mh6Ba5DpAmPG2GC/vrhKd3XUNfQJjOZI
	zfVFfkQm33LnXkrndu+zFlKuvesOZHskZcBjtBF4qvrtqPvYXx1AZCDj
X-Gm-Gg: ASbGnct7oOnqdfSf7Ho4Uo6LL3QjznpqtS5JVo3d9vVvPCqBtusPDjPUpPVlRLT6hWl
	hX/0XXsW7l2+b4dmXlfRihDzEerHVvNpBxZzOE9ZcaGB53DRiozXqCuMToAupq2BKsUbjkmVTrE
	2cspqME/Zz1Rbe+AhV7tPnvjf9w47he9RvudggEda/n+INb+fmM6ge2nMUY+kxsSxFjhbDMgTb3
	ZvDwh3s/CoH3NfZnhr5OgPyPKAi8C+2hPpOa0W8yY2U6PiiyJMUNvKzf9eTTSEoO15Y0ZIzWVOY
	OMEESg90dOeqtyholQElFXLuR7oH2ioORiba7LMdIr5lHbNuVTWMOlhwh0IOmvpP1ujv20o8jhp
	Gueh3T/dfqqaKaGjzMBQMQXie2TyLZGlUMbilQHxFlcEjQHk=
X-Google-Smtp-Source: AGHT+IGHsAz1XUgqjX9cBNXDDceT4RSYaRrx53ol9Kht+YGnRRfTcQN5imeqv3DeXohNMYqhdx9Bfg==
X-Received: by 2002:a2e:a00e:0:20b0:34a:7575:36db with SMTP id 38308e7fff4ca-351401fd0f5mr48965051fa.33.1758015723646;
        Tue, 16 Sep 2025 02:42:03 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f15a5835asm32481881fa.4.2025.09.16.02.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:42:02 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 58G9fwKw021585;
	Tue, 16 Sep 2025 12:41:59 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 58G9fts1021584;
	Tue, 16 Sep 2025 12:41:55 +0300
Date: Tue, 16 Sep 2025 12:41:55 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: pengdonglin <dolinux.peng@gmail.com>
Cc: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, bigeasy@linutronix.de, hdanton@sina.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org,
        cgroups@vger.kernel.org, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v3 11/14] net: ncsi: Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-ID: <aMkw4zTLRJqpVGCm@home.paul.comp>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
 <20250916044735.2316171-12-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916044735.2316171-12-dolinux.peng@gmail.com>

Hello pengdonglin,

Thank you for the patch, looks reasonable and justified.

On Tue, Sep 16, 2025 at 12:47:32PM +0800, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> Simplify the code and remove the inner rcu_read_lock() invocation.

Reviewed-by: Paul Fertser <fercerpav@gmail.com>

