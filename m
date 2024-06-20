Return-Path: <netdev+bounces-105103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F18990FAF8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 03:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8621F212C2
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0FE469D;
	Thu, 20 Jun 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/Qx6Y5u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE964184F
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718847037; cv=none; b=nEmfzqGwe3nX4L5BM4syRiN7yLL5H5C4C5/cOJO30xRi3f9cjysFZ/8nW/LXJwBvHwpkXlaaCWgVabGVp/ztyw0C7fr84F0+mQtLSN1BygYIEWwDdmLyDTgOtEVrPmETnj8NR1XgfIZZdSux6D7y0WsKX52eVPz6fkTiIyvZ4yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718847037; c=relaxed/simple;
	bh=rYbChGLlVvPgG0egHfWaWLROG/xd7JRNvksBGYQxxwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1t5EasDs0fjwZtzVQcPP1o5Lna7JLcKTIk9egsPzhZweO9Sxvz6wNsEkB6WNGA/lyIfUuZT4H3Amc+uG3Dphhn06k27oWbczmNAd9srXgRGKaEjUXJdIbF8vBhyCB65EPFvN4VRhWCkCK6ZnDviyjDkKLKqbMLIWWHNIYrSjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/Qx6Y5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1CDC2BBFC;
	Thu, 20 Jun 2024 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718847037;
	bh=rYbChGLlVvPgG0egHfWaWLROG/xd7JRNvksBGYQxxwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W/Qx6Y5uOUoVEmavtf3sP9gBcFJYZkildVhz+H8ScI59H93EPMcyJZUqLyu5O+Akw
	 kflFL6m8CrS6U9KdHmq6bQMo0oRlrwxuJizsKHcMiGVMI34q6OWgsDIwItueVe1cK3
	 7hi4+63r/yB+EjjRvjXOgtSIIgrsvdvWwuZah6VbY9FFh9QW2iXNcF5qO1yQmqqmux
	 dbyieeHlHdQw1oKTb52+ul2ysy0Bd86fdMtavcpt1W7Yo3qTVdfsUIg8RFhO0Mh8Ri
	 jvXOuXlWQWAUImT0y2zcNzHQvcACMgZNKfSNsz38J7b5X+wzO+R+lL1ykJa2etEdUJ
	 behkGunnHseYg==
Date: Wed, 19 Jun 2024 18:30:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <David.Laight@ACULAB.COM>, <andrew@lunn.ch>,
 <brett.creeley@amd.com>, <drivers@pensando.io>
Subject: Re: [PATCH v2 net-next 2/8] ionic: Keep interrupt affinity up to
 date
Message-ID: <20240619183035.51ec1beb@kernel.org>
In-Reply-To: <20240619174317.6ca8a401@kernel.org>
References: <20240619003257.6138-1-shannon.nelson@amd.com>
	<20240619003257.6138-3-shannon.nelson@amd.com>
	<20240619174317.6ca8a401@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 17:43:17 -0700 Jakub Kicinski wrote:
> On Tue, 18 Jun 2024 17:32:51 -0700 Shannon Nelson wrote:
> > +	if (!affinity_masks)
> > +		return	-ENOMEM;  
> 
> There's a tab here instead of a space

The rest looks good, I'll fix when applying.

