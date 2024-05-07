Return-Path: <netdev+bounces-94335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 385238BF341
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23B81F21850
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B75086AE3;
	Tue,  7 May 2024 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="czZj2bFr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp95.ord1d.emailsrvr.com (smtp95.ord1d.emailsrvr.com [184.106.54.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC428662E
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126207; cv=none; b=jFyzi8I/H2SInhfmzX5V6meP+J6Ifq4JTwQHtIsAO5JFKcak+6khqxh0Z+WU7SueCvzRwY50XZUyxFR/KTUzss39RiGdM0UnrubRxQcKooi3zffpArGUrpgVzicnFJGnmKZe/4Ay0/bwiz2di2ex8ALofaHX1QZKars2jdBdd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126207; c=relaxed/simple;
	bh=/TOv6fP0vQebAxVEplVjdQOI2uzzY71yM9grBNcY6Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOIUQlHWgA6U8JOZ0AHH8Lpn7vcHp2IQzpyLB0r44VgNGWorjrf5GgtXEh3e7KQEqV7GgvZAOSxHOCOJHS44Yp9Tw6wuiSTtb/HBkw4OA0qYh07O0TGg8oj0lE4E/e8y1hcecCW1bmoNqEf4AYRCBkKyob0FSaeRUMq6Pu1VGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=czZj2bFr; arc=none smtp.client-ip=184.106.54.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1715125612;
	bh=/TOv6fP0vQebAxVEplVjdQOI2uzzY71yM9grBNcY6Zw=;
	h=Date:From:To:Subject:From;
	b=czZj2bFrbwg8I9OB+pHUp343UlDFKC46ap8dR/xAGn1p+Bt65WKBMMTzsautPOHFk
	 J19fxMTqeqj6IJlS/daQySD6lbc2hSAAjcmQcHuB146QbwpBuJc3VDRh88oN11dLia
	 CWKVB/6mf1cbASHBLSrmGA6TMpJ5mAOFFouVrDKs=
X-Auth-ID: lars@oddbit.com
Received: by smtp12.relay.ord1d.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id AD4E3E0099;
	Tue,  7 May 2024 19:46:51 -0400 (EDT)
Date: Tue, 7 May 2024 19:46:51 -0400
From: Lars Kellogg-Stedman <lars@oddbit.com>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hams@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
	jreuter@yaina.de, dan.carpenter@linaro.org
Subject: Re: [PATCH net v5 1/4] ax25: Use kernel universal linked list to
 implement ax25_dev_list
Message-ID: <z5l3dfardxqrwf2lzzpktuifqaxvv2clrgah5gnz4t6iphskeb@otrcl5cwyghx>
References: <cover.1715065005.git.duoming@zju.edu.cn>
 <bd49e83817604e61a12c9bf688a0825f116e67c0.1715065005.git.duoming@zju.edu.cn>
 <sijkuyypbnelg3w2shbxm3y6zu3qhfurvpvkoij5eluolnqr5w@y5dq74ycxzkm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sijkuyypbnelg3w2shbxm3y6zu3qhfurvpvkoij5eluolnqr5w@y5dq74ycxzkm>
X-Classification-ID: 0df3cc1c-0dba-498b-89fb-d2d91bbb82a1-1-1

On Tue, May 07, 2024 at 03:43:11PM GMT, Lars Kellogg-Stedman wrote:
> On Tue, May 07, 2024 at 03:03:39PM GMT, Duoming Zhou wrote:
> >  typedef struct ax25_dev {
> > -	struct ax25_dev		*next;
> > +	struct list_head	list;
> 
> Would it make sense to replace this with:
>
> LIST_HEAD(ax25_dev_list);

Sorry, *this*:

> +static struct list_head ax25_dev_list;


-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS

