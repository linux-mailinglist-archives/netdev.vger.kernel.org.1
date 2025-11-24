Return-Path: <netdev+bounces-241159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E23FC80ACC
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC7F3A7179
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 13:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB73043C5;
	Mon, 24 Nov 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tg6nN7s3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C00303C93
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989724; cv=none; b=C3JWrfOaBstBcq0EDfQUhn9n1ubi5muydFXCTw2jDrFjnhFMxd5Ps7MDvNdSvobJ9/MYGBIlcJYxkU9I6GjTHH+ffvSwVyi8nWgsK+OVc6wY/sy4MaSCCHXHlQsX6HpOqQl34oDhoNkyygUWNw1VLr/M6ZGhhqULNEbDMV0Q9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989724; c=relaxed/simple;
	bh=LRQLpElnCTWDWNW9Td6/qX0W+seZnE0G09+QK9uBOiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5/iZHVoUA6bhGSr/2o5eoJ1RyfRwKbK6pAA15roZH09YVJrLLn6qCH1GUqrCicF/uDD/NNr3nj+Ahfm6XUXByfaeWRO5WRAo+EUpyghlufbg6f22CAXSlWXW9qn3nWPnkPKYA2VcaRucIT+boPrQk0Ts+Hku7RW0/nWzCscfiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tg6nN7s3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47789cd2083so24955795e9.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 05:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763989720; x=1764594520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OFiNT2yuBLPQnDGcfP34CBXyTQtTTHRIFkGdeL1qNTA=;
        b=Tg6nN7s3nvWOX++gmZUJLVXllmzSJIMXILbVPPC8hE/M1L7Mg2ZprgHDXVcA/4qZmV
         AKqNcDycO+UD/asjW6F/ZmGgZ5aiXJfMJwCIYWTOstvo8fDodHFujz1O11G7pgcOCjPd
         HZKcRRjAC2TBSKLxpmC/jchn7jeHLPVuOZVT066net0xDf4MzvTLAUnaFAB4uqw6UNnZ
         Y+USy8VZ3dAxFKMeYIr9Yq6ZbaslnvIxGGPBz/DDRY1PJSnJMHKJOleUyNYVEl2oQQMc
         FjPDEe8a1yjhxrrtqr9eCtzacGjClv7Rw5S+XTbHvofbkA1ntkwAZfDojegbLZ2Gbqz8
         u5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763989720; x=1764594520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFiNT2yuBLPQnDGcfP34CBXyTQtTTHRIFkGdeL1qNTA=;
        b=V4lnkCDCtncPKcK4XokSXubeyOv+UeEFpxQxobVqj48HE3R7iSLqkH56TdvnuzKcRW
         eyKsZJmbNcGTfSFIbriiYYHwFcM8k5h+EhfVidbu8abFIKKOMPgoE60BCspEGEFnuJ3Q
         +WHyHKTjes7zEFrDxI9GjEjroK+rglc5bA+EU21aG2mfwAM0wHzEkq4UuxF1RLW1bZSG
         fbDRpPbyn5HAZTHwoJ8WQV11W2tNjGzHvDVglbddyqtmfLRU3VbrZQVw4GH3C1QPE6RQ
         2SKAb7RSNy8Jy5b6JKGFaVbF7rHzMXHYmGN992ywK/yB0+rIXoU8RyAVAHM+hOsdzWtF
         1Zkw==
X-Forwarded-Encrypted: i=1; AJvYcCVbSFdv5INW827nQh9PvQzo3krUH+hVFkZ8HZSi7ddd11qHzvIL8t1+0UDGIhfQK78k0ZzWJz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6h6foCJLHrck3jK503yPOdVEb9RoryukNdNDDb6LR+M3dC2P
	ZXNEJYPdMU/cht+6K95+0XILO/OJDgmH0G6HpudUVlqpDMgeaN1Se8jg0QGD8v7hyvo=
X-Gm-Gg: ASbGnctObQZNsQerN0Rga15lcsKSjXsibMEQihQ70v9AdYSk1BnEeCUAr0IGYbcEI2j
	LkocnRhZsJppl3MIZjDq2EsUd91zt4iccUNC37Nz0AHS5YR9QEzS/oXB1KrJGt3GCqHKTmQnwCg
	Q2D+86yiDXo7wQN4VpvVWSUVxciYJ2zPjXUA6XgmweQuI+lexetDkdGpdvDq+rJchyOwDNXr5aB
	gnrKWFr7Au7+QY5uo+lLK1HduSd80uSxBlHTKIPuPjTNaWWPCMSHmXpn+FytCOfcBZilWYigwns
	d0ROOAWg+ihFK9Sjnw28dqtQpXrUgc3wuDQIpZ086jxZw3b7sB9em/4cZxG6Umon5zJxa6QSJBA
	9CDk4fiMIk4QsQkYirhSACbqLoVq/Mj+8yG4rNdTYPOCb0vlw58k6dpJvYzo6HHOL+o9oK5sItP
	4/rBeK4p0k8RRG+w==
X-Google-Smtp-Source: AGHT+IFxd/ZKfXS+EiW3Bb+wPwpdBt+GnQG44EQt8KOfagxj4/d+mHzOdami5PdyEs3Q4/rVvSsLrg==
X-Received: by 2002:a05:600c:3543:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-477c1142268mr93235725e9.20.1763989720132;
        Mon, 24 Nov 2025 05:08:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e574sm28198949f8f.3.2025.11.24.05.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 05:08:39 -0800 (PST)
Date: Mon, 24 Nov 2025 14:08:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, efault@gmx.de,
	john.ogness@linutronix.de, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	calvin@wbinvd.org, asml.silence@gmail.com, kernel-team@meta.com,
	gustavold@gmail.com, asantostc@gmail.com
Subject: Re: [PATCH RFC net-next 1/2] netconsole: extract message
 fragmentation into write_msg_target()
Message-ID: <aSRY1AI7zDF-h-A9@pathway.suse.cz>
References: <20251121-nbcon-v1-0-503d17b2b4af@debian.org>
 <20251121-nbcon-v1-1-503d17b2b4af@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-nbcon-v1-1-503d17b2b4af@debian.org>

On Fri 2025-11-21 03:26:07, Breno Leitao wrote:
> Refactor the message fragmentation logic in write_msg() by extracting it
> into a separate write_msg_target() helper function. This makes the code
> more maintainable and prepares for future reuse in nbcon support for
> non-extended consoles.
> 
> The helper function takes a target, message, and length, then handles
> splitting the message into MAX_PRINT_CHUNK-sized fragments for sending
> via send_udp().
> 
> No functional change intended.

> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -1559,6 +1559,20 @@ static void append_release(char *buf)
>  	scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
>  }
>  
> +static void write_msg_target(struct netconsole_target *nt, const char *msg,
> +			     unsigned int len)
> +{
> +	const char *tmp = msg;
> +	int frag, left = len;
> +
> +	while (left > 0) {
> +		frag = min(left, MAX_PRINT_CHUNK);
> +		send_udp(nt, tmp, frag);
> +		tmp += frag;
> +		left -= frag;
> +	}
> +}
> +
>  static void send_fragmented_body(struct netconsole_target *nt,
>  				 const char *msgbody, int header_len,
>  				 int msgbody_len, int extradata_len)
> @@ -1748,13 +1760,7 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
>  			 * at least one target if we die inside here, instead
>  			 * of unnecessarily keeping all targets in lock-step.
>  			 */
> -			tmp = msg;
> -			for (left = len; left;) {
> -				frag = min(left, MAX_PRINT_CHUNK);
> -				send_udp(nt, tmp, frag);
> -				tmp += frag;
> -				left -= frag;
> -			}
> +			write_msg_target(nt, msg, len);

I would call the new function send_msg_udp() to make it symetric with:

static void write_ext_msg(struct console *con, const char *msg,
			  unsigned int len)
{
[...]
			send_ext_msg_udp(nt, msg, len);
[...]
}

By other words, use "write_*()" when struct console * is passed
and send_*_udp() when struct netconsole_target * is passed.

The inconsistence confused me... ;-)

Note that write_msg()/write_ext_msg() are cut&pasted.
The only difference would be send_msg_udp()/send_ext_msg_udp().

>  		}
>  	}
>  	spin_unlock_irqrestore(&target_list_lock, flags);

Otherwise, I confirm that it is just a refactoring with no
functional change.

Feel free to use, ideally after the renaming function:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

