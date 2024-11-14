Return-Path: <netdev+bounces-144973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FFA9C8EA7
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5952D286603
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DF713D881;
	Thu, 14 Nov 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sC5MI1b8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684E9476;
	Thu, 14 Nov 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598821; cv=none; b=aFQJcqYqZ+485YodozIMCJDgOP5zDRLEU10rwZNgEHptg863VG8g51CtfmEU5BvhZ/c7pB6bdQAO9mZfhdL1rCFMYiJ8y/3f4Hprrc8C/3RyDj5vw++Hrz2s+LwlA3OnZCNtg3+U9dB6CoK0YW/Ag8pPs4U7mWfztmolmPjgqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598821; c=relaxed/simple;
	bh=5sAZI5hjU+4WJJlB5HyWSKOqlo5rJUKPUVmXXRmlTP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8sdFw9WZxTBvaxQpKxNH/FA3jZXVYad6yMIyIsDBS77XfnKOfB+G3tHwRXeCzHcVF7rG5aFpgPDJ4ytzaukV9bGHoHFWUDYiZ1VzbpkNfKcewud18yOK0gSuFX9DwHUXSH2vLYebPd6tqY6qrTa1v8D4M2o4BxOHohdBWnMWCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sC5MI1b8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BnvCuWB02FYo5F4Vm/+yNbrOAyV0kATHIXMKDigxXLw=; b=sC5MI1b8uGOT9S1tXUcybdKhCE
	pr7xOGDrFXU4SqU42+O1JBnz+qAekxjmGBG4qmOQsjlzfpjDe/HVT4svPV489zH8DuF9gyF6rybfA
	qnq4P+mFXmP9RnokG501P0OujJOJWGnZusZIZ/14Z7gFXQEgPoeiPn6W5dYivbKqtWlE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBbx9-00DJaT-K0; Thu, 14 Nov 2024 16:40:15 +0100
Date: Thu, 14 Nov 2024 16:40:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net 1/4] rtase: Refactor the
 rtase_check_mac_version_valid() function
Message-ID: <83569c8e-d4d0-4790-9df6-87b06872229d@lunn.ch>
References: <20241114111443.375649-1-justinlai0215@realtek.com>
 <20241114111443.375649-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114111443.375649-2-justinlai0215@realtek.com>

On Thu, Nov 14, 2024 at 07:14:40PM +0800, Justin Lai wrote:
> 1. Sets tp->hw_ver.
> 2. Changes the return type from bool to int.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

If you want these in net, you should add a Fixes: tag.

    Andrew

---
pw-bot: cr

