Return-Path: <netdev+bounces-33318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B360D79D60D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7EA281A1D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB82319BAF;
	Tue, 12 Sep 2023 16:17:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A819BA0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14833C433C7;
	Tue, 12 Sep 2023 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694535435;
	bh=NHzhhdgkKVg1Z1E3fYBIdKIk4RTB0+vFhn+9IZszqnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dvg1vea6OcIDuaEpOraqnWAIxKe+l8/GYbdYF5qPwBxP46C/4b5XjwSg1nFsLmQeR
	 4UwczeO8uuI9JTEn2i3wsiaE+9Z0aUN0tEPLoKEen3K/VrvkouGb+DYDRlJYAcr18l
	 FJAYYi/A3KhMQwydB7oiqu9TNb7z/kpq+I8cTzZIxk8QWRY6BZrxe2o4JgBgMwY/1p
	 AR1GxvilI/paKfYxhKnpNaX/dvHhuZ0m4elLmckngBZ/Eiqvkjr39GERj5bkSbLUGs
	 VBnBr5VjMMY20uWPFU5Js6eMzeZ3K+QpApNYIoYLVlT+phe5rP2/Rp6uj7CFer6/bB
	 mt5TyWxhV041Q==
Message-ID: <4ae938a0-6331-f5d6-baa5-62eb8b07e63f@kernel.org>
Date: Tue, 12 Sep 2023 10:17:13 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v15 01/20] net: Introduce direct data placement tcp
 offload
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, imagedong@tencent.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-2-aaptel@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912095949.5474-2-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 3:59 AM, Aurelien Aptel wrote:
> As a result, data from page frags should not be copied out to
> the linear part. To avoid needless copies, such as when using
> skb_condense, we mark the skb->ulp_ddp bit.

Not consolidating frags into linear is a requirement for any Rx ZC
solution (e.g., the gpu devmem RFC set and accompanying io_uring set for
userspace memory). Meaning, the bit can be more generic and less tied to
ulp_ddp.

