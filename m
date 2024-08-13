Return-Path: <netdev+bounces-117962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FB9950173
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94FE9B22094
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FDD17CA1B;
	Tue, 13 Aug 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rV2hgrEc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C58BF3;
	Tue, 13 Aug 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542244; cv=none; b=EwPeeuFab4h8ZGBltaGR25eVEdW9uJsaqV0ic1BotJCpwk1daBBzz1SKZB0qL6i7arv7e1GegWjLX9MXZVcptWM0mA6itZttS37c6IHusZh8X4YAZ2euQoifQYgdaNw6blbeJyFMif42eUJ1rUiufYnTxLKhzb9Eqx/tIhF6L/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542244; c=relaxed/simple;
	bh=SxG354utO1q5nwLS9z0IUadYK5y7vlEJwJWJ/6D6G48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMqOqsOyaAiDbSL//aluhk12tZ1908kkBhudGGt8TFC2H36soQz0aXjZOAtFFeC+OAxzdzDs69CT02nC1RL2ZYfyvOmMh401/oHg4b3Ufh12GeR038V7nM8uKixhGO/3Wkh/SmuelWjAGL13OBRePQ8d+r1bvuctxM+VZC7wcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rV2hgrEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86463C4AF09;
	Tue, 13 Aug 2024 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723542244;
	bh=SxG354utO1q5nwLS9z0IUadYK5y7vlEJwJWJ/6D6G48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rV2hgrEcOPHdVhYTtRA2dTRcOHxoAON/lXryn9dcSFzaYu15XWIKHFM2b0nX+bxHh
	 DU+9pLyMZ+cynmC3c+TnQxo8uVgI0uD37XR1oKSHYOfu+M2cogqRqv/iW1wpa1krRu
	 l+/qZ7DpRUZFNXp311UKACq4HdxeyrSo87UYDuhU=
Date: Tue, 13 Aug 2024 11:44:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Timur Tabi <timur@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 1/5] driver core: Add simple parameter checks for APIs
 device_(for_each|find)_child()
Message-ID: <2024081328-blanching-deduce-5cee@gregkh>
References: <20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com>
 <20240811-const_dfc_prepare-v1-1-d67cc416b3d3@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811-const_dfc_prepare-v1-1-d67cc416b3d3@quicinc.com>

On Sun, Aug 11, 2024 at 08:18:07AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Add simple parameter checks for APIs device_(for_each|find)_child() and
> device_for_each_child_reverse().

Ok, but why?  Who is calling this with NULL as a parent pointer?

Remember, changelog text describes _why_ not just _what_ you are doing.

thanks,

greg k-h

