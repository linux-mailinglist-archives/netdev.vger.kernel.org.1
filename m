Return-Path: <netdev+bounces-33827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 890CA7A067C
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F97B20AFF
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883F6224D3;
	Thu, 14 Sep 2023 13:51:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE4224D2
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 13:51:27 +0000 (UTC)
Received: from iam.tj (yes.iam.tj [109.74.197.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6731BE3
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 06:51:26 -0700 (PDT)
Received: from [IPV6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1] (unknown [IPv6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by iam.tj (Postfix) with ESMTPSA id 75FD0347B9;
	Thu, 14 Sep 2023 14:51:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=iam.tj; s=2019;
	t=1694699484; bh=iw2ehxsdDpVMLQra3RWSGmg9oaLYwU6vkUiNLsXxbaI=;
	h=Date:In-Reply-To:To:From:Subject:From;
	b=kWgQNKwZ5Sp2LVG7n3pL9UNdfI60J0giCDaEZENv0cK9e6KRRka3lrJ+l2/BPLWeJ
	 h6akg09I53YjaoTxZkQwv5eCPUdpG2QDcifZlFlYwOtwiA998Wkf+8bHVyMSwgis6C
	 bH0xSnn6BOUj1ZOHsRy0/uovFKhqfYogzsCoW0xFrCoGTW65yoGZY6OCoeEIkC1MbI
	 h0cvBSXKna5u+YG/WSgTNxIna0McwGhGwZlDnHuKuz7GDNrPUn4/rdlkRFgtpdS+pm
	 3WjZ2XHdqSEaJ4GyBrp9iUTFu2IiUr5bD6XoAHTiFK4E3DDwzx6d5b8G3Qi1ePcrLW
	 RXSpBXBZTCrYg==
Message-ID: <ab9737bc-cc91-6ccd-e104-4a94899e69e8@iam.tj>
Date: Thu, 14 Sep 2023 14:51:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-GB
In-Reply-To: <ZQA0VxB1hVqH2o/9@debian>
To: netdev@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
 David Ahern <dsahern@kernel.org>
From: Tj <linux@iam.tj>
Subject: Re: IPv6 address scope not set to operator-configured value
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Apologies if this doesn't thread - I've had to manually add the In-Reply-To header because I did not receive Guillaume's reply and only discovered it via the email archive.

Not being able to set the scope causes a problem. The scenario in which I need to use it is interfaces with multiple global and ULA addresses where a multicast-DNS responder needs to choose the correct address to send in reply to queries. This affects both avahi and systemd-resolved which currently seem to chose almost - but not quite - at random; but enough so that it often breaks.

E.g: if the query originates from a ULA address the response should give a ULA address; if the query originates from a global then a global address, etc. In fact, being able to simply set scopes and enable the responder to be configured to use a specific scope would be helpful. It'd certainly avoid having to hard-code logic to determine what address ranges represent a particular logical zone.

