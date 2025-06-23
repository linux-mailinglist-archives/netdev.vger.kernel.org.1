Return-Path: <netdev+bounces-200399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC0FAE4D32
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E41918983C6
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8222BD015;
	Mon, 23 Jun 2025 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv70p9fr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E12AEE4
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705024; cv=none; b=ly3KL5YifXXEm9ZldkDmstb64kiFbHtwIJf9EvT13e4QvWPKkrmPh7Svm3KlyLw8HCaq30QxGDWpnBnwjPBhKBdNSdNi55tgbUSEZBfsu03INHt5Am3tTPuZFktn+QBsLFmhBbMLao7e3LidRlTCh7C2fkNhcDvhiDvVsHo3Cm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705024; c=relaxed/simple;
	bh=+lHQELDriFFFgcaQNcJEf1UJGlJsMy19W+PbpdYdtB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgrJsIKbbuuxoR7I8UKc4wZKPv0wrc0giaxYOkJTOpBBzK8+LA44Fk+6z4gMfiTX0TTNNBduSGngaxFJjI0BNftmzd/oL9lhvJ9jCRMbNpSeK0XJ0fn9cHMcbHFPVGQQHgmrC032aFd52beNJaNVgb1nQNimdHTEUyCaUekFmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv70p9fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F738C4CEEA;
	Mon, 23 Jun 2025 18:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750705023;
	bh=+lHQELDriFFFgcaQNcJEf1UJGlJsMy19W+PbpdYdtB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cv70p9frwAn24Tkma60VkWeQTH8BJZqwO0C9FR9lTjtW4eyjIVKm2mCHWUDp7vyE1
	 k6RWlDyUqfD0yygyxg95jYvsqMAgBp0lhMJANZBvjXmgzahrDOK+++uj/WJfmK2okS
	 En37fq/G3tGsJErpyxayHLKTdKfFpzIu0x7zlSCgeKL9uJDimQTM9NctEOQW/huU83
	 j37UeVbdZnZV/Oc2pkaSuskgD4ozCyJ+ryxTZNz50pzhd+Y/8ZTyziO+Dda7bekQPX
	 wz4XyeFfpPAkaXbc2JqtTkSea8ETpOl0CDCmdFqeSh46Y+HtYJDLUuom9wOQpXrAEj
	 BKbTGRIteikhQ==
Date: Mon, 23 Jun 2025 11:57:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "xin.guo" <guoxin0309@gmail.com>
Cc: ncardwell@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: fix tcp_ofo_queue() to avoid including 
 too much DUP SACK range
Message-ID: <20250623115702.76bdd8a2@kernel.org>
In-Reply-To: <20250617153706.139462-1-guoxin0309@gmail.com>
References: <20250617153706.139462-1-guoxin0309@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 23:37:06 +0800 xin.guo wrote:
> If the new coming segment covers more than one skbs in the ofo queue,
> and which seq is equal to rcv_nxt , then the sequence range
> that is not duplicated will be sent as DUP SACK,  the detail as below,
> in step6, the {501,2001} range is clearly including too much
> DUP SACK range:
> 1. client.43629 > server.8080: Flags [.], seq 501:1001, ack 1325288529,
> win 20000, length 500: HTTP
> 2. server.8080 > client.43629: Flags [.], ack 1, win 65535, options
> [nop,nop,TS val 269383721 ecr 200,nop,nop,sack 1 {501:1001}], length 0
> 3. Iclient.43629 > server.8080: Flags [.], seq 1501:2001,
> ack 1325288529, win 20000, length 500: HTTP
> 4. server.8080 > client.43629: Flags [.], ack 1, win 65535, options
> [nop,nop,TS val 269383721 ecr 200,nop,nop,sack 2 {1501:2001}
> {501:1001}], length 0
> 5. client.43629 > server.8080: Flags [.], seq 1:2001,
> ack 1325288529, win 20000, length 2000: HTTP
> 6. server.8080 > client.43629: Flags [.], ack 2001, win 65535,
> options [nop,nop,TS val 269383722 ecr 200,nop,nop,sack 1 {501:2001}],
> length 0

Looks reasonable, AFAICT, tho perhaps there's some implicit benefit from
reporting end of the DSACK == rcv_next..

Could you please add the info about how the packet from step 6 looks
"after" this patch? So we have before / after comparison?

With that please resend and make sure you include _all_ maintainers that
the get_maintainer script points out. You missed CCing Eric D.
-- 
pw-bot: cr

