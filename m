Return-Path: <netdev+bounces-144269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789019C66D0
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2574CB2BE64
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 01:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145792E40B;
	Wed, 13 Nov 2024 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRrJMxqz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4897C147
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461925; cv=none; b=QEpb1XfSIibpBVCzc7d8fFpIJc188eujFrgMbaI02vR75wJT4POhYSQifF/UQvHsynNmQw/p/zwaGTtj4+8HWMkEQAMRPvR3zWuIGUn8CYVbnbFvU9qJoVwSXSCV/6tGLkdknZPnPqAiF0IVbFXp7rIzaQmyXRNwRanSa/0kPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461925; c=relaxed/simple;
	bh=blf8kgpYDmhdgW/Flh9pWbEP6SrsFKFvVuIQBvpyYHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bR4ZBvkl1eFmyUWz2Jh6slMwHigLsfLnQEEIaQNLW3tA6bmqYxdSOnbJd6GivKbQTfOwAL6ifSpsndlqe28D+BdUQtp/AHsdfOA9rhhtn6wlI54rwS3cz7mKrafZyHiLXaULGO9fNACUfeIWSSButIXl9rLcD7ONlulNua2ipQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRrJMxqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FEBC4CECD;
	Wed, 13 Nov 2024 01:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731461924;
	bh=blf8kgpYDmhdgW/Flh9pWbEP6SrsFKFvVuIQBvpyYHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NRrJMxqzzws7KocKEj7PRaohis6WiwlT/MJbpcuTOlrg9Um6+//YAOm1AsDIPI/ld
	 K3OdF0EVc3miI0VI24khgiK/kZlCJI1B6k/2EtLpnH3QeBl9zdBCvQ/qEgw/okTdzG
	 J7kIDwFC5MMZihktAlgWqszd4W9kYVDbeOJRvloH6epXFfMD4qhsSoobXUaKuDgtvr
	 m9K2i0f21nh7Q8pCTQrNsnQFLaHeMmLjNoTaNsQc4fGZDUOUDLSWdYvQsKXcpa7NVs
	 /H7aSlYyTgOzta2cD4y5P+74sIqQH+t6sp2V93gFd3KXBuk88us+PSdgbJV9Tcxc7j
	 XTQ4zNQrD9Stg==
Date: Tue, 12 Nov 2024 17:38:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 2/2] tools/net/ynl: add async notification
 handling
Message-ID: <20241112173843.2831e918@kernel.org>
In-Reply-To: <20241112111727.91575-3-donald.hunter@gmail.com>
References: <20241112111727.91575-1-donald.hunter@gmail.com>
	<20241112111727.91575-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

some comments for your consideration, if you prefer to keep as is:

Acked-by: Jakub Kicinski <kuba@kernel.org>

On Tue, 12 Nov 2024 11:17:27 +0000 Donald Hunter wrote:
> +    def poll_ntf(self, duration=None):
> +        endtime = time.time() + duration if duration is not None else None

we can record starttime here, and avoid the complex logic..

> +        selector = selectors.DefaultSelector()
> +        selector.register(self.sock, selectors.EVENT_READ)
> +
> +        while True:
> +            try:
> +                yield self.async_msg_queue.get_nowait()
> +            except queue.Empty:
> +                if endtime is not None:
> +                    interval = endtime - time.time()

then here:

		if duration is not None:
			timeout = time.time() - starttime + duration

and rest as is (modulo the s/interval/timeout/)

> +                    if interval <= 0:
> +                        return
> +                else:
> +                    interval = None
> +                events = selector.select(interval)
> +                if events:
> +                    self.check_ntf()

