Return-Path: <netdev+bounces-105107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7292990FB06
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 03:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F0E283A0D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 01:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D3A134A8;
	Thu, 20 Jun 2024 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpvXOGQO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3118EB0;
	Thu, 20 Jun 2024 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718847667; cv=none; b=m3V0GxoeJ2Mtu0FhjwOJJE8CzTNTAkB9T44fKTJjc4IgOE8Deul8KwZPuRxpY3tpzybw/1PZQSU6nmg2pjLY9cMxkuOrcxUWEDCQ8wsI3iRs9LOqJHpmURz7aoaHIipuvEy3mwmVWBOYqc23NpnGEXEZCz2uHbI7gx2c+NY3KqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718847667; c=relaxed/simple;
	bh=K88cdgONoxCP4Mq8HbQumsBZXKRfVsYIC6AsnXC2rfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Duo+rrnZ55IohoPkExiqXQ8ik2KF5bORqBhIJlYJwTrNhp9D90HaWFroMUo6Y514q+s4Cf3bKzCxL/7INLU5QGsd7Pew6PSeFCvKmDsMk55QRy4DwhRiQmHsk/c4A0nYnWbzprtTcktZvwkd3YqxW2wBXjbS0Fo8h1CEfEzKP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpvXOGQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1600BC32786;
	Thu, 20 Jun 2024 01:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718847666;
	bh=K88cdgONoxCP4Mq8HbQumsBZXKRfVsYIC6AsnXC2rfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JpvXOGQO5oSHHF6JtDdTq29NtD4heeX3mh84O7+5qYUXc9ZBOTOVI4PqgBkB146Ak
	 I3T1mp37D9sZpbIFWFCtW7GI+RGqcMPdyXeed5G4JnU85x3g3wSQeIWbLjmQYDc6Rd
	 1fH4AQGwRUB8CODF2Qw3mczX6OApHmLHdd3d2GgDIa/R84phKADTEZwiLleloh6eO4
	 tmoX3xaB+alWAO1dZoZeg+kVFmYNRHNSW+XungwfOJqa9VAlOUzbjGpsjeVrl1hdil
	 ELd4LAK+McFvvXmvkzhhp8cLkucqOt4poy51B8p5fgjluS3kh368XIsT51D9zpP3z/
	 9AJ741UnLxMnA==
Date: Wed, 19 Jun 2024 18:41:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Andrew Lunn <andrew@lunn.ch>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: dsa: mv88e6xxx: Add FID map cache
Message-ID: <20240619184105.05d8e925@kernel.org>
In-Reply-To: <20240620002826.213013-1-aryan.srivastava@alliedtelesis.co.nz>
References: <20240620002826.213013-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 12:28:26 +1200 Aryan Srivastava wrote:
> +static int mv88e6xxx_atu_new(struct mv88e6xxx_chip *chip, u16 *fid)
> +{
> +	int err;

err is unused in this function. Please make sure you look at:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
before reposting
-- 
pw-bot: cr

