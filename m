Return-Path: <netdev+bounces-54471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72655807348
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FFB1F2188C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE973EA90;
	Wed,  6 Dec 2023 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZEk6Qus"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD379A;
	Wed,  6 Dec 2023 07:05:12 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d03fb57b69so35457805ad.1;
        Wed, 06 Dec 2023 07:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875112; x=1702479912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jI9BXQ6U/V2yKZyvwgWABlpSIS9z4T/U+cMlmbF/xPw=;
        b=QZEk6QusF/Z6Y3zUnMvSlQnTKeGLOBLHrk+cG/2UThR1DXmJS9lUACV1swELq5vW0l
         keTEaG2Yr554q+L0cfJBZlurwpxYcZkjGku9zbuueK/qeHMa7oKz9qGhYbnBDH44/cgw
         9XQdkxyETE3fn+mL1yBhGPuNWuZ3ZVYxEic5XbAbMIcAKZ9waDzbyGvVpD2cCIk88o8H
         pzGgqfCsWrG9loGc5tY0C9qQjDzP6Irx0hfXhQQgG8wCnsobKj6pmOZGSleDLJSkApdB
         wRQLNGAEtX8H1OeDlkdS7JKZwZTJDpxCjzPCKC7mhxLEsF43h2kdb1MVpOXmr6NIRO2L
         U3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875112; x=1702479912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jI9BXQ6U/V2yKZyvwgWABlpSIS9z4T/U+cMlmbF/xPw=;
        b=PM30QV46gfDypPhCG2WPp/sllSJe3iVtg7BGa2CIdHtIrMP3I4v/ZVLcnVwDXDCP1b
         fdj4nDwp6Ixo4tHS7NH5gjcBi05E/MkXq6XasBtMWL0cj2bqCEg5LsWg7pzBbBoAtBhK
         MhNHp8fd8+WkSV4SXGxsnUsQLPHCVdc5fyffjfh9Q3xfDCP0UBFOxXUIgSxNJ0KtR6jc
         xcGVyPPY8BdojRULHA5DrI4ApWA6BRXPljS9a57e67Wk7Gey1I1M/UdFnediMGF6fvlB
         OS4y/DCPERN6XSRm9nT54bx5VLRyYExUSwxdb6TA6642SzmchXIyJErCnDneRs5bcQS8
         c6vA==
X-Gm-Message-State: AOJu0Yx2J9xbZgMyfH/xU7cjuNgmN2k5zPksnSWvU9XQC7mO2oNmVHdN
	l/vEwxvPeBvDuhkW6N/nWsCVlHHkGzSYUCkI
X-Google-Smtp-Source: AGHT+IHMIrp6vihpwyJjk/bwe3y89ZutbMbWmzySJQKcGLrlc8f7z7dP/gTw5TpWkY8ph2J3cEdwmA==
X-Received: by 2002:a17:902:f68b:b0:1d0:c6a6:10e8 with SMTP id l11-20020a170902f68b00b001d0c6a610e8mr759970plg.56.1701875111692;
        Wed, 06 Dec 2023 07:05:11 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b001cfad034756sm7458267plb.138.2023.12.06.07.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:05:11 -0800 (PST)
Date: Wed, 6 Dec 2023 23:05:06 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Florent Revest <revest@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] team: Fix use-after-free when an option instance
 allocation fails
Message-ID: <ZXCNouKlBlAKgll9@Laptop-X1>
References: <20231206123719.1963153-1-revest@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206123719.1963153-1-revest@chromium.org>

On Wed, Dec 06, 2023 at 01:37:18PM +0100, Florent Revest wrote:
> In __team_options_register, team_options are allocated and appended to
> the team's option_list.
> If one option instance allocation fails, the "inst_rollback" cleanup
> path frees the previously allocated options but doesn't remove them from
> the team's option_list.
> This leaves dangling pointers that can be dereferenced later by other
> parts of the team driver that iterate over options.
> 
> This patch fixes the cleanup path to remove the dangling pointers from
> the list.
> 
> As far as I can tell, this uaf doesn't have much security implications
> since it would be fairly hard to exploit (an attacker would need to make
> the allocation of that specific small object fail) but it's still nice
> to fix.
> 
> Fixes: 80f7c6683fe0 ("team: add support for per-port options")
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  drivers/net/team/team.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index 508d9a392ab18..f575f225d4178 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -281,8 +281,10 @@ static int __team_options_register(struct team *team,
>  	return 0;
>  
>  inst_rollback:
> -	for (i--; i >= 0; i--)
> +	for (i--; i >= 0; i--) {
>  		__team_option_inst_del_option(team, dst_opts[i]);
> +		list_del(&dst_opts[i]->list);
> +	}
>  
>  	i = option_count;
>  alloc_rollback:
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

