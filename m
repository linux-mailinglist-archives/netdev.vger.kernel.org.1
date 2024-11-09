Return-Path: <netdev+bounces-143558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C36B9C2FA8
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 22:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D0F1C20AFE
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8883519F124;
	Sat,  9 Nov 2024 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poGZvsZQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A86233D62
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731188413; cv=none; b=EpSpyP2vJB8HPCrclRwU3vsW9VocZZOi/z4LhP+Oelsv8ers2bkhJmkQTZq6FTm5YAHfzawi+gG7VYFk/uIqX1t5CEJSR4scexSWcigcLGpfm/oWMsySRPNAT/ZGBMNRx1lqAY2frCVn415uWaDA4LhCoCa6XnEMO5faaS+RmAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731188413; c=relaxed/simple;
	bh=+I3SYL4CCAM940xNoTQADYjVhW13fnxp6IHA06LgJIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GChB/l036u244Dx3Ahk9SphyS8p4+0EKmY2+DCA8Qk3nDCIwT8P7WH2+0Tt9EYw9iO8Hr6jJBlcs134dDF6TT+zgpvSKG+7A5YPiggcogwTHlpImzb3pLiQ/PEoLtpR/aFAR3VabQNR4NRD46eCtJyR9EM045nI2ZmRzXHvSZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poGZvsZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD97C4CECE;
	Sat,  9 Nov 2024 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731188412;
	bh=+I3SYL4CCAM940xNoTQADYjVhW13fnxp6IHA06LgJIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=poGZvsZQw68shVpCVxDGkfvZqFWxon8w/6pzDaNfBz22deXiod3MK5JpjargS1QK+
	 O6r0XCToWUWtSRJuYCUjT81kYSkpliH+agtyAZKF4gJRaoJFbqhDSWDC+23zH0/5rQ
	 RDVKvEUGSDd8Yt4CLh6ywf8JurWNtXd6PAGz1nqTrWr3Vt+W46d3behUo9jHznuclw
	 4kxXa0jhgWHyCrWyJcusdToUVp9Uk+JkkCDdExpdVo1nFJrdZSO8rP49f/NILcVTM6
	 7Rf11rZCBcbHsYbn66DT2njJMoB8Fwrk7ui6oxAIApoQcHViwvcsup0S7u7M2FrsbG
	 gQ+/UUjoeXBiQ==
Date: Sat, 9 Nov 2024 13:40:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: add async notification
 handling
Message-ID: <20241109134011.560db783@kernel.org>
In-Reply-To: <20241108123816.59521-3-donald.hunter@gmail.com>
References: <20241108123816.59521-1-donald.hunter@gmail.com>
	<20241108123816.59521-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 12:38:16 +0000 Donald Hunter wrote:
> +    def poll_ntf(self, interval=0.1, duration=None):
> +        endtime = time.time() + duration if duration else None

could we default duration to 0 and always check endtime?
I think we can assume that time doesn't go back for simplicity

> +        while True:
> +            try:
> +                self.check_ntf()
> +                yield self.async_msg_queue.get_nowait()
> +            except queue.Empty:
> +                try:
> +                    time.sleep(interval)

Maybe select or epoll would be better that periodic checks?

> +                except KeyboardInterrupt:
> +                    return
> +            if endtime and endtime < time.time():
> +                return

