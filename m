Return-Path: <netdev+bounces-205012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BC7AFCDC6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8347A929E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BAD21B184;
	Tue,  8 Jul 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DoTHOkyp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F841E521B;
	Tue,  8 Jul 2025 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985373; cv=none; b=u3taNXDeOD/fWkpsadKMSxrrx4hdJ5CzpA2eNATf+fB/qMR7vGMcbLQAnsL+HID/wKyoQGd/ZXiqpJoDDOJfsajDG3DGzI7gE+gGrNYshhN6kMd3f8vSymSDmCrgxRhIUtM4Jeopwe7xFwtGeXuRPDsMv72XFgZI8iLfI9YN6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985373; c=relaxed/simple;
	bh=wX+weQ9lYgX+AvYXERCfQ/irzOOk9f0kwlCXEq1eHpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmvIXb7IRwYx1HXC84h0IjgEFg6VdNoarqdafG9NWZ71rS0hGUfYRXsrCapAuwZxiDAP9tzwW4bgN3jJ6WQ1QZqs7adGqmtVuWGBG1LR72IDpLcSrNho9IDtA0286AUMbH5V89Pm3TTaKThQxLx3bCCz02TAz6rkza1lprrjy5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DoTHOkyp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KxbpLIroB0AR3eVUIT2dsxIfgL40nkxskdHcSRUvP0E=; b=DoTHOkypysymNDz2/4BgPKNZIF
	HaBNHq4JgAXQdELFGg0lu4I0FV+NwLbrjg5CxVj7SeM05Qx+rp927qWGly5HZaFXvwYjvwXSB4s9g
	Ir67FZsJxgwLIDCs5EGngLR7z5rxZt/fy8mZgRAA3EaobcloEs62X0TQLUb/0y0NHU4M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ9QP-000pVq-Lg; Tue, 08 Jul 2025 16:36:01 +0200
Date: Tue, 8 Jul 2025 16:36:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	arnd@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 04/11] net: hns3: use seq_file for files in
 common/ of hns3 layer
Message-ID: <1aa974fd-4992-45da-a548-7ccb2861a362@lunn.ch>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
 <20250708130029.1310872-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708130029.1310872-5-shaojijie@huawei.com>

On Tue, Jul 08, 2025 at 09:00:22PM +0800, Jijie Shao wrote:
> This patch use seq_file for the following nodes:
> dev_info/coalesce_info/page_pool_info
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

