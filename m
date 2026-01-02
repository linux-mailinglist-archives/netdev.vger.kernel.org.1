Return-Path: <netdev+bounces-246541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1424ACEDA24
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 04:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2591030006C4
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 03:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AC6286D7C;
	Fri,  2 Jan 2026 03:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LBmMWM7v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360623C50A
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767326070; cv=none; b=IvNAOYM78sRAo6v3ohWO9BPenFX2eMJ8K0/ggMpkmABlPvpGzculwvHE1L+/zg88IJ7CtkFXZ5MwdtiJjB+PbIA8OvFt4tkcQ486U1sE5XFu3dJn71tQblzgrPV/HQr61FXL285cCZ37ivlA+JT1xCf4PQ733Qro089D+dbPCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767326070; c=relaxed/simple;
	bh=4W96kceTgRDO6riquS8LZhyqpYebYcVxbTxl3NRRvfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqJ1/gt2SW+/DgPOxMpxC1Z77txj8mhY+Tk/uX0f587RaO3+ReyuD8NDlFlMBdMjCSn8/hehPIAooOaWLIEbU7VnwkB/+lcXMLg7fPtCDTFLlSv6gOm3jVDVCUihAgkFSLknAcH4LUvSP4O9FRWZK6VwDaaS0PKEf9d7l9xb1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LBmMWM7v; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso73758665e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 19:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767326066; x=1767930866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgwSs+Ut9uvC7pYYQWpYdvwDZnsVMLb+gA399q5HzxI=;
        b=LBmMWM7vxDKQ3IvzlwLRKwdFsv6BBE+tp7nlIGT+f70uGB4KBcd+0U45W2rr4IcMAs
         O2DNME0pxIXGg4k66Bbq1AhWq6a0fkTw8yMrS4aSsq2XDqS5/wGnbM8L9kM07d9BakcB
         c2R/bOKHMNIWUnzSzk71AFwFSEiIiFUd6MFRFhQntSmKtyUcNHIJn57IKpURLULjgKVc
         cDU1m3OqFxkmOU8iDGtyRSw7wKqLn+2wZSnpAPGNvGe6SWBu8DY8uHQbYjMkakkOs6UY
         0/jih/ZOJnb4EWPeEq2UgOAmJgmFpEeGQ7leKhwWZbH2rz/VdZYmEtUQimDtM2jrx0ID
         r8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767326066; x=1767930866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VgwSs+Ut9uvC7pYYQWpYdvwDZnsVMLb+gA399q5HzxI=;
        b=Rc/yk+d11Na84CNfnq4gWDVMiisGaAfF0YLSnsbkX7H1XKaqjgMGvP0yPkXpWpFGYI
         Np8zI6BpfMDel4Jb+NAT4nRh0cjVEckRDbC3qqyKH/0G2pPiiAkAFo8w7ndfh9wt5nxB
         l8EyGU7YDAGyHLlVFqVteN5r1QAVLqsW4yMctb0FqeQtD1UjCnbkrtvqwk1hoSbaSSHo
         4EBVRwwD366PhqngaOqQxuNcaJXHmCuY5+09q7VwZ5QLTS296ogLJvqO5YDJXMsuTtI2
         +g6l826u9srOXCEXfZMtezLmadyLs1RC36D+9UEDqA2wB/piUOxW4fA3Eh1Y9w/+EhJO
         ++cg==
X-Forwarded-Encrypted: i=1; AJvYcCW4Hdw4Hhxc5VEDgThEIpukPhkwzeSL1ovJHuz+P+rKR7cDr1HFJFGIFYjUc/qoZpHv+lA8DSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU6LDO19CILLfGtiHnjOdqPNPptTeWAUY52/zUsbQ9ojc8VTbw
	cxk+NG8Xr0PuADziJ1GZrrI4esIzXjcolEMrYNxF6PS8tgbxW+p6uQIBZNN+2lHfvW8=
X-Gm-Gg: AY/fxX4RWW5+0/FrlPkDhr0iPSlNYKzI6UIAjRg2/wcsOA8vi+SsXEWwoe9iWiE9SyD
	E9HeoMyBYVDvI8VJ2BEprkt/xt4tD5SWF57CU2496y6eKAa/UZlOfOvL9HG/dh8xrjgnOAMhSiT
	8aLk4NVOYrxh/8rM964X9uzjVD5ir69eOgdJ/YirqvKKM4tuwuBKlaF8rbw5D0tnCxdwt5tdfMa
	Wx2gMyzhmWnzEHqWAiYoFOMLIrZFMTltlHIQfI6i3RbN1I0j9OLMB4MyPJv7LLLQJDYU/h2DydU
	wc39FRVjYmBITEtSgO3JvrAIcMhFY7yZQbtMq8X4oGXbCiaRTa0NVtY1KCWtUGAyJ7mpsbxN7Us
	G0yqANJ0hOH4BnBhpa2rWzTPkAwm4KNZ3lkH3A1Ddt/4nGmLQzjtt/WwysioOD4eg6iS9ig0svJ
	iy58k=
X-Google-Smtp-Source: AGHT+IHyxKybDF/tf0j/xJuCBlfK2pNZMVwyrYTFVFm1sofS2xbsjiPhw5XJosBhay+2p8wvuw4wZA==
X-Received: by 2002:a05:600c:3ba7:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-47d1953d798mr495478105e9.11.1767326065831;
        Thu, 01 Jan 2026 19:54:25 -0800 (PST)
Received: from daedalus ([2804:5078:9c5:300:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724ddc30sm158376991c88.6.2026.01.01.19.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 19:54:25 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asantostc@gmail.com,
	efault@gmx.de,
	gustavold@gmail.com,
	calvin@wbinvd.org,
	jv@jvosburgh.net,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 2/2] netconsole: convert to NBCON console infrastructure
Date: Fri,  2 Jan 2026 00:54:14 -0300
Message-ID: <20260102035415.4094835-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222-nbcon-v1-2-65b43c098708@debian.org>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Dec 2025 06:52:11 -0800 Breno Leitao <leitao@debian.org> wrote:

> Convert netconsole from the legacy console API to the NBCON framework.
> NBCON provides threaded printing which unblocks printk()s and flushes in
> a thread, decoupling network TX from printk() when netconsole is
> in use.
> 
> Since netconsole relies on the network stack which cannot safely operate
> from all atomic contexts, mark both consoles with
> CON_NBCON_ATOMIC_UNSAFE. (See discussion in [1])
> 
> CON_NBCON_ATOMIC_UNSAFE restricts write_atomic() usage to emergency
> scenarios (panic) where regular messages are sent in threaded mode.
> 
> Implementation changes:
> - Unify write_ext_msg() and write_msg() into netconsole_write()
> - Add device_lock/device_unlock callbacks to manage target_list_lock
> - Use nbcon_enter_unsafe()/nbcon_exit_unsafe() around network operations
> - Set write_thread and write_atomic callbacks (both use same function)
> 
> Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 95 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 58 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index dc3bd7c9b049..248b401bcaa4 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -1709,22 +1709,6 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
>  				   sysdata_len);
>  }
>  
> -static void write_ext_msg(struct console *con, const char *msg,
> -			  unsigned int len)
> -{
> -	struct netconsole_target *nt;
> -	unsigned long flags;
> -
> -	if ((oops_only && !oops_in_progress) || list_empty(&target_list))
> -		return;
> -
> -	spin_lock_irqsave(&target_list_lock, flags);
> -	list_for_each_entry(nt, &target_list, list)
> -		if (nt->extended && nt->enabled && netif_running(nt->np.dev))
> -			send_ext_msg_udp(nt, msg, len);
> -	spin_unlock_irqrestore(&target_list_lock, flags);
> -}
> -
>  static void send_msg_udp(struct netconsole_target *nt, const char *msg,
>  			 unsigned int len)
>  {
> @@ -1739,29 +1723,60 @@ static void send_msg_udp(struct netconsole_target *nt, const char *msg,
>  	}
>  }
>  
> -static void write_msg(struct console *con, const char *msg, unsigned int len)
> +/**
> + * netconsole_write - Generic function to send a msg to all targets
> + * @wctxt: nbcon write context
> + * @extended: "true" for extended console mode
> + *
> + * Given a nbcon write context, send the message to the netconsole
> + * targets
> + */
> +static void netconsole_write(struct nbcon_write_context *wctxt,
> +			     bool extended)
>  {
> -	unsigned long flags;
>  	struct netconsole_target *nt;
>  
>  	if (oops_only && !oops_in_progress)
>  		return;
> -	/* Avoid taking lock and disabling interrupts unnecessarily */
> -	if (list_empty(&target_list))
> -		return;
>  
> -	spin_lock_irqsave(&target_list_lock, flags);
>  	list_for_each_entry(nt, &target_list, list) {
> -		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
> -			/*
> -			 * We nest this inside the for-each-target loop above
> -			 * so that we're able to get as much logging out to
> -			 * at least one target if we die inside here, instead
> -			 * of unnecessarily keeping all targets in lock-step.
> -			 */
> -			send_msg_udp(nt, msg, len);
> -		}
> +		if (nt->extended != extended || !nt->enabled ||
> +		    !netif_running(nt->np.dev))
> +			continue;
> +
> +		if (!nbcon_enter_unsafe(wctxt))
> +			continue;

In this case, I believe that it should return directly? If it can't enter in the
unsafe region the output buffer is not reliable anymore, so retrying the send
the buffer to a different target isn't correct anymore. Petr, John, do you
agree?

> +
> +		if (extended)
> +			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
> +		else
> +			send_msg_udp(nt, wctxt->outbuf, wctxt->len);
> +
> +		nbcon_exit_unsafe(wctxt);
>  	}
> +}
> +
> +static void netconsole_write_ext(struct console *con __always_unused,
> +				 struct nbcon_write_context *wctxt)
> +{
> +	netconsole_write(wctxt, true);
> +}
> +
> +static void netconsole_write_basic(struct console *con __always_unused,
> +				   struct nbcon_write_context *wctxt)
> +{
> +	netconsole_write(wctxt, false);
> +}
> +
> +static void netconsole_device_lock(struct console *con __always_unused,
> +				   unsigned long *flags)
> +{
> +	spin_lock_irqsave(&target_list_lock, *flags);
> +}
> +
> +static void netconsole_device_unlock(struct console *con __always_unused,
> +				     unsigned long flags)
> +{
>  	spin_unlock_irqrestore(&target_list_lock, flags);
>  }
>  
> @@ -1924,15 +1939,21 @@ static void free_param_target(struct netconsole_target *nt)
>  }
>  
>  static struct console netconsole_ext = {
> -	.name	= "netcon_ext",
> -	.flags	= CON_ENABLED | CON_EXTENDED,
> -	.write	= write_ext_msg,
> +	.name = "netcon_ext",
> +	.flags = CON_ENABLED | CON_EXTENDED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
> +	.write_thread = netconsole_write_ext,
> +	.write_atomic = netconsole_write_ext,
> +	.device_lock = netconsole_device_lock,
> +	.device_unlock = netconsole_device_unlock,
>  };
>  
>  static struct console netconsole = {
> -	.name	= "netcon",
> -	.flags	= CON_ENABLED,
> -	.write	= write_msg,
> +	.name = "netcon",
> +	.flags = CON_ENABLED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
> +	.write_thread = netconsole_write_basic,
> +	.write_atomic = netconsole_write_basic,
> +	.device_lock = netconsole_device_lock,
> +	.device_unlock = netconsole_device_unlock,
>  };
>  
>  static int __init init_netconsole(void)
> 
> -- 
> 2.47.3

Sent using hkml (https://github.com/sjp38/hackermail)

