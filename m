Return-Path: <netdev+bounces-33587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F68D79EB58
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C301C20B6A
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524A01A700;
	Wed, 13 Sep 2023 14:43:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09663D6C
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 14:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5BCC433C8;
	Wed, 13 Sep 2023 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694616199;
	bh=TcdpeQqTgWXLKjXs4cgg1umm18ZVqBeNTX/ihlp8c2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fk8k1GByOFextsBhqS+xt40pbELOKWUMJbVNexuDQWBQ2A9kBQ+xZzBmrlfty+9jy
	 hCsKBLuA5DD4/BRpKMDQrWQmPK2xz69cZvWiSiucM6a0+LW4ICP/qxC7fBNXt8450j
	 L5rCnoxzLl3B0uBJLIXEQaEeQsb6Va9USFKDCR1eVZblfdd1aBekLdWGBTOwxvl2rM
	 gF5sunHLV7TTGiQO19lIKh41OP8wqy6RCQ2kE3b/2TZ3HZYqz6kuIS27+LITTHRWJI
	 w2V/k5NBSnpPsiFv9dr/D1kd6Za5ZjoqYiI4BdOodtK/F/JRUEh0oG1QCwA+dhrcHc
	 FLy/IFJonEKAQ==
Message-ID: <767a9486-6734-6113-9346-f4bef04370f0@kernel.org>
Date: Wed, 13 Sep 2023 08:43:18 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Content-Language: en-US
To: nicolas.dichtel@6wind.com, Hangbin Liu <liuhangbin@gmail.com>
Cc: Thomas Haller <thaller@redhat.com>, Benjamin Poirier
 <bpoirier@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>,
 Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20230724084820.4aa133cc@hermes.local>
 <ZL+F6zUIXfyhevmm@Laptop-X1> <20230725093617.44887eb1@hermes.local>
 <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
 <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
 <640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
 <8f5d2cae-17a2-f75d-7659-647d0691083b@kernel.org> <ZNKQdLAXgfVQxtxP@d3>
 <32d40b75d5589b73e17198eb7915c546ea3ff9b1.camel@redhat.com>
 <cc91aa7d-0707-b64f-e7a9-f5ce97d4f313@6wind.com> <ZQGG8xqt8m3IHS4z@Laptop-X1>
 <e2b57bea-fb14-cef4-315a-406f0d3a7e4f@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <e2b57bea-fb14-cef4-315a-406f0d3a7e4f@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/23 8:11 AM, Nicolas Dichtel wrote:
> The compat_mode was introduced for daemons that doesn't support the nexthop
> framework. There must be a notification (RTM_DELROUTE) when a route is deleted
> due to a carrier down event. Right now, the backward compat is broken.

The compat_mode is for daemons that do not understand the nexthop id
attribute, and need the legacy set of attributes for the route - i.e,
expand the nexthop information when sending messages to userspace.

