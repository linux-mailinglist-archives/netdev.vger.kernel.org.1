Return-Path: <netdev+bounces-150519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 503B79EA7A0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 06:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797601888F41
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 05:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14731D6DBF;
	Tue, 10 Dec 2024 05:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs7p2cJt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C81A01C6
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733807829; cv=none; b=ELegyO3EgrlUrWqsOa3RCB1OXqoeSO2uH9mZdfqAy1h9FXw4qRiGEuri4rIEdQaBZgG/ZUobQwOcJLKkZKm/dVGOJlTDw4pFTEk0Fve/qBlnpvkqW+ps3gxniubKp8BZWLI5wfV4IOR5akz0kTT8n9CVlzQ9l1NIfUcbd1ek/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733807829; c=relaxed/simple;
	bh=omcPm/+iNfFwqpUHoZgS7GWCcQ6rktq1lykFQYpiOBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K24rhmUfve8DXYcvNwJ0jWXYzO9sQTNTTnHwWZhK8C4/3vsdMcQ2PiqsmvstBN+5TmRbaw6YJeHfaWvXnOr1SZ/haVXO1nBtncE0MEAXxEb6q5DguaZ1EHRLmEoZpuO+G5iDkXHDhly1sNRbJu/Bd5lUPSNZ95b4AhIUgScSBoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs7p2cJt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166360285dso12778995ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 21:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733807828; x=1734412628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9OJ01TgOq0G7xYxgCKirKmr+56LQpsASz1uNA/kq4V4=;
        b=cs7p2cJt7JcxAwhJ/UtfrWzVYABoOAMRGdsk2SJeHUOs0VkbedEwi0ZNx3lFJBrxWx
         OgO2i67ajcIVZX1hge7mymfHwtm++wMLiG5Pf02ZMsXiiO+ylITniOsOe95OqhLjY5xW
         xfcccTaEKTCua6Tay8TKutC3vZpWBLUhXe/DecPbMFMOhYE+LalKXZJWA1TLN28o2ZE9
         6H4aVEJy/BqqkFhINIuBD97dJotNMTepRjxVHVXcDUNrNGnGEZI3FNCrbj7UVn6P89VS
         fZwJlg1OwlkSQq2F9QNd88Ye8YvuEzNuDCWiVTivsfHLZIA9fw98mCe8eGEzZhKt7bNh
         Bxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733807828; x=1734412628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OJ01TgOq0G7xYxgCKirKmr+56LQpsASz1uNA/kq4V4=;
        b=Umy5zjHIv/OWa+Om8uIrNUi9uro4y1Cmc11FdwFK8Kc24m3yWLJdk1+zvsXYQZpkcb
         QV0cMqEzuYqc7wgAzKxfzx1d+RQUW7MWg3hM3MPfgoowAvSq07lUFYsAMiStjdrqKpT/
         GlW5aSNgnVzrYTZLUMv3nzj1VcOXBEY81e7GG6eyV5IfQKNKTY0mZsgrNv/Tdg4KF3vo
         toHLkHShDhx7S6RCTVf+HwJpvM5nofoBPTw8rlQZLdNdWuKQ1hI1vGvG+g5v0X38z0qG
         B8qbsWs7/GnLYuBev/j7YkDya1FX1f5TDzQnzuZIBtAOuE3bMjLopa6V6seXDtymsZvl
         zKRg==
X-Gm-Message-State: AOJu0YwfDMKpyLxnH0yPTiUWINKBALnU9UqIiskcWzx5Hek/5RiOhQtH
	hqg+eTZ/UFf6CFyYLmWVgmFpcnxJ8wSmAB0+iQ8dGZ+g62u2+wZU
X-Gm-Gg: ASbGncs4MjPZ6MdUcXIy8q+qjZMdSxIE74k9w556qJnfFkZT0Iw6eqwjFj6Q0g0rbhA
	7pPDDWBhsS8tkkTYN/N+Bd89dfhTkteCgPdxL1sBBNOrgU4annREw1cmK1MprD65isK7+heKEUo
	ii1DTmCiQHSr1DofyFaRucJx4WAz5w6ML9JW51E0XkH5kXmcUjC+SEFVMvZE+7fgI26l4+V1IrA
	nkTfjqoi8Z8lOxJu52b3+wgZtfkhG09jZoHUItY7mMogvFSGWm8EXSAHMYV
X-Google-Smtp-Source: AGHT+IE+wd397gqslluIxEX6iuq/JgEqnmIUF2ByZwQx4gsIWpqdOukdm4gQTQH73QJGV4kZftfJIg==
X-Received: by 2002:a17:902:f7cf:b0:215:781a:9183 with SMTP id d9443c01a7336-21614da30c6mr178596605ad.38.1733807827681;
        Mon, 09 Dec 2024 21:17:07 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:5939:82cc:e9ac:c4c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f63772sm79184085ad.281.2024.12.09.21.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 21:17:07 -0800 (PST)
Date: Mon, 9 Dec 2024 21:17:06 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: dave seddon <dave.seddon.ca@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: tcp_diag for all network namespaces?
Message-ID: <Z1fO0rT9MZs5D61z@pop-os.localdomain>
References: <CANypexQX+MW_00xAo-sxO19jR1yCLVKNU3pCZvmFPuphk=cRFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANypexQX+MW_00xAo-sxO19jR1yCLVKNU3pCZvmFPuphk=cRFw@mail.gmail.com>

On Mon, Dec 09, 2024 at 11:24:18AM -0800, dave seddon wrote:
> G'day,
> 
> Short
> Is there a way to extract tcp_diag socket data for all sockets from
> all network name spaces please?
> 
> Background
> I've been using tcp_diag to dump out TCP socket performance every
> minute and then stream the data via Kafka and then into a Clickhouse
> database.  This is awesome for socket performance monitoring.
> 
> Kubernetes
> I'd like to adapt this solution to <somehow> allow monitoring of
> kubernetes clusters, so that it would be possible to monitor the
> socket performance of all pods.  Ideally, a single process could open
> a netlink socket into each network namespace, but currently that isn't
> possible.
> 
> Would it be crazy to add a new feature to the kernel to allow dumping
> all sockets from all name spaces?

You are already able to do so in user-space, something like:

for ns in $(ip netns list | cut -d' ' -f1); do
    ip netns exec $ns ss -tapn
done

(If you use API, you can find equivalent API's)

Thanks.

