Return-Path: <netdev+bounces-70500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FF084F49F
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 12:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39381F2BF04
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662C828DC1;
	Fri,  9 Feb 2024 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="2DJRdChK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1720311
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478095; cv=none; b=Zt8gV5e6MaO35ABgv0VvlGwQeF6j4iSCJEhSVmexFJbDRhmbwQvmAPmX+ISMfCa1BdnrtpqtHwTbcFs4F6G11BK0qtOQPwJmnZLm40Jpz6clOHChYN6QUch5GR4aqg2hSC1FUutGbcPpPP8sD2CfPklJmUl7F+BuCjwTuernyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478095; c=relaxed/simple;
	bh=jsV6Q05spsARdsUx7PsdcGfeqOSWG910k6O0rdcZ654=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjUbtbVgL9+IrN9CC0RQvF64oHvPjFG6RNzUQ93fvkDfhe+ZxF9vXhb8VbzhK7WnAXrrbkVmazAg9GTcr3v2QnNbJuwqJmFoICFWsGc/BtLwUc+4+JV4wQNjOUVMQk1gAUngzoxafOnMjuZru8MKGsJm7Ab7pVH4cnYasZ72uuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=2DJRdChK; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc7510bcf22so414755276.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 03:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707478092; x=1708082892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JmAGAlNOBwAkXycDteKiYx3YFg5zFvHxTBJjlrAv40=;
        b=2DJRdChKlZfacTKCGlwSD+33InIWw3ToYHezqiXs6jh2bFpFvYTsW/HxD9r95E81u7
         WcYmJCGmcFPklX7xFzjLmTddas8oUOrClhPdvWaMP0kNVobV25yls/7OAqruV3P5AHhE
         tm1BILU2HGLcGSs2S4E5U3+CQG5E2sVAkVN0sUj+2cRHo2B3168NjLtMKHipta3UiHBg
         /zRfyprJxQHwUdgKzG8xKcrKik7audk18XDdGB4CQ785G/XI2Unyyt33NcAmdhi9ata2
         JsDdldj9sU9uAWEn8hpA5OZcMCqjwYREF0rM35Duk2DUd+VCcyqEWqeodCYLcuu0QTgV
         RBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707478092; x=1708082892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JmAGAlNOBwAkXycDteKiYx3YFg5zFvHxTBJjlrAv40=;
        b=JCC0yjH/LpaGMsh2Qznzt/rpcacMHZrlAdSNbVnvOVMDQnPkl1KYcVyOYWt9h+oyc/
         aI01pXaQnAP8js5YACNDb8YoQStRA11DgZum6dtpRXliq8z+5wvgMdVYq+ca5iSee09r
         KXkH42D761YTmnibMr7p1XC+jKs5cAD4gc7zKckY4LNxXXMONJu3sd2zyCn26LnFntcV
         bQcwYlUOg1yENOZ7D0Mw1QZ0qtfQfPKMoRROF7kRlPIy0gnZ8eqeY+2M+ldHDxCIhSCI
         +Wm142TTiOA0Dl3QoblpaqqDhwlooq1kB4pLhfHb2kk4IsV+V8JNIEiHKZcZu2WsT5rP
         vZJQ==
X-Gm-Message-State: AOJu0YxV6UGP4UQTORN1PNdl/NaYSPAD+J8bgbkjg3PHL4v2VADg5XdY
	0N40uNqqgN++3w9JQf9CEr6JRcQ1VVxZbzF8dfDjggVMsL7SjB25lN0a3SZD5DeTqS75Jmjw1x2
	3j6WXaAlNtjaXfgSaujM9ouBPA7g8RjA2TZSW
X-Google-Smtp-Source: AGHT+IE0YxluIiUicDHA/Qtsu2ESEdM6yJT+8F8FJrZZ9tgDULzmF84M9tp0cmMi16YkCcqjsGVj00xm1L6K5FWEGOo=
X-Received: by 2002:a05:6902:2501:b0:dc6:c32f:6126 with SMTP id
 dt1-20020a056902250100b00dc6c32f6126mr1237214ybb.22.1707478092336; Fri, 09
 Feb 2024 03:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207222902.1469398-1-victor@mojatatu.com>
In-Reply-To: <20240207222902.1469398-1-victor@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 9 Feb 2024 06:28:01 -0500
Message-ID: <CAM0EoM=mMtB4zFmrmhUx7UJW+JT-jSoTozWRVNgc1JOJ8-D+pw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: act_mirred: Don't zero blockid when net
 device is being deleted
To: Victor Nogueira <victor@mojatatu.com>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, kernel@mojatatu.com, pctammela@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:29=E2=80=AFPM Victor Nogueira <victor@mojatatu.com=
> wrote:
>
> While testing tdc with parallel tests for mirred to block we caught an
> intermittent bug. The blockid was being zeroed out when a net device
> was deleted and, thus, giving us an incorrect blockid value whenever
> we tried to dump the mirred action. Since we don't increment the block
> refcount in the control path (and only use the ID), we don't need to
> zero the blockid field whenever a net device is going down.
>
> Fixes: 42f39036cda8 ("net/sched: act_mirred: Allow mirred to block")
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> v1 -> v2:
> - Reword commit message to emphasise the bug is caused when a net
>   device is being deleted
> - Reword subject to emphasise the bug is caused when a net device is
>   being deleted. Original patch subject was:
>   "net/sched: act_mirred: Don't zero blockid when netns is going down"
>
>  net/sched/act_mirred.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 93a96e9d8d90..6f4bb1c8ce7b 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -533,8 +533,6 @@ static int mirred_device_event(struct notifier_block =
*unused,
>                                  * net_device are already rcu protected.
>                                  */
>                                 RCU_INIT_POINTER(m->tcfm_dev, NULL);
> -                       } else if (m->tcfm_blockid) {
> -                               m->tcfm_blockid =3D 0;
>                         }
>                         spin_unlock_bh(&m->tcf_lock);
>                 }
> --
> 2.34.1
>

