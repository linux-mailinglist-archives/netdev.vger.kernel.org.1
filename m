Return-Path: <netdev+bounces-184299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA96A9470A
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 09:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADFE7AA79D
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 07:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ADF202F96;
	Sun, 20 Apr 2025 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9fyRq0d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4419E99A
	for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745134356; cv=none; b=YyLiG9742WsT1krrrLTm3buPibJRKUb2GDPxeJp1v2+0GXtY7tiq17NnlvMgj2kC0msMPwxhDO/OmxQkb8QCPaMFxAqNRXHtZEp2f1IxVcgTvH+P7rs7rkdicy6m1dwL13D/YIxs2hycn5+WHNkUoD+jiac0uZ0EudlFVJj3gOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745134356; c=relaxed/simple;
	bh=esKQyW/mP1LV/UEbhdKK0N8rrzF46fMuyMoO4EiNSPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPYL86hG7voUvrKL374s20lVoDnzvmbZaqpCDu+ddzqbMCnh+Q8eQYRZsq3PKIjl/R6FaPySJ4PSCdHrcN+rIl1H2lS1SyORCYKEhgfkYcXqxXzOIfxVORbnCHuihP5pHvl03paM6+3SybUDt0dVcHsytIdZlSG6BqPf/kL3w9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9fyRq0d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745134353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rPnHwBvdjCpYN+ILr2KbqTtEgmvkuvdxNwRCB+YgauQ=;
	b=N9fyRq0dkhMucXB+U1kBn20fDDLsb1U17VjaEjCYTQ89I90R8pY8M3jiHhTRG1daL1QJdd
	HQ9ebxQYwm+qo+NASRAGuAdfym6WpF0spFrthfRb8qi5st54Ld62P67Y4Ki6XuNkl3P3ez
	itn9Iu3qh+N43/1L6McuCw95oDUi/zY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-6ggKwxEkNLidjU4OgOV7JA-1; Sun, 20 Apr 2025 03:32:30 -0400
X-MC-Unique: 6ggKwxEkNLidjU4OgOV7JA-1
X-Mimecast-MFC-AGG-ID: 6ggKwxEkNLidjU4OgOV7JA_1745134349
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39126c3469fso1061679f8f.3
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 00:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745134349; x=1745739149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPnHwBvdjCpYN+ILr2KbqTtEgmvkuvdxNwRCB+YgauQ=;
        b=wjcitfupsL1b9apDnbCb4GuCJSDTs8XpGUrzZMf13CYEgUJ4vd1PVTZu2mZWyxuukj
         iVj68JPXsB4fmxRW0pYWWQpKTL0XZtxnus7OW3cm2PpQaSXxw5NxOKZ1zt/DN/O8L85X
         wSX5KxE7lm4R5q3ZscDb7YiWL2tG9ZO9s9Lc3GaBbHeGIq0mVkn+16eByLQFW5vTuLsM
         u2oIzAlnnypn2MiXN0SfUJxOYXFJAu/YcVm1Nvu12oUVFzzaHN3r/N1HH6tJ7roZHy/l
         6VYrRw3zsz+I7KSqMhjL2GeQa5P+IS4/smbhXmHGefCxUntsKbaVIJLe5ERYF6KdEQfw
         pA6w==
X-Forwarded-Encrypted: i=1; AJvYcCUPSHo7Vr8DHzyIZlOKlcxQEbt53E6cf6QUQuHbF+ab5OsipI0+B0n7gokSIhWyX/9OlfjHBtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOG+pkk2l2C87LijqfbaFwv+Dyz+697Y76wK+eeGbeh/2dU7q
	6Hi+GiaukW4ZLZe8MNe9HbTfUYTGxJGZgq98vw2xfChSKf3n68GszL9ou+fr9HNDKy/1DVDLeZB
	VmBx5C1vrVUUeiflsoQbtz2xtiuH1xxjHRzGULobKUMTUjCSKwLPn7w==
X-Gm-Gg: ASbGnctoTf2i8PDzkHLpA7PiVLtXCFcwv2552YxygAEG0PlX+mL4Gnw4diJVPjd+alJ
	UMbdI3/CMqNRUF3a0ElFKQfJeqGPgVOHzh9R2njdEVnSNTtuNcJZuhhJgWr+twOCxP+qROK1Asg
	HUVgTqhK4+CYr2+OtzGVVXF55WfiMsBCl1XHi1VFxBZclHbm0jcezQUWq2shalX+MPHT5pnop0p
	jxpYlk/M6YA3jG67F0hrnU4HJoHEwAFUBD4OdtfiXRRcE8RCiUa3DX3qnLd+d6Hf9KmQAb8zXQY
	vb4Tkw==
X-Received: by 2002:a05:6000:186b:b0:391:13ef:1b1b with SMTP id ffacd0b85a97d-39efba60fa2mr5482623f8f.30.1745134349131;
        Sun, 20 Apr 2025 00:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrKjCeXR5ka2I9nS9y5bI3Cx9j6H+N6iEOY7I61+u5OZx0tRo6cSozrM/uepXIEFdsuc6J+Q==
X-Received: by 2002:a05:6000:186b:b0:391:13ef:1b1b with SMTP id ffacd0b85a97d-39efba60fa2mr5482610f8f.30.1745134348687;
        Sun, 20 Apr 2025 00:32:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4331a9sm8243556f8f.36.2025.04.20.00.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 00:32:27 -0700 (PDT)
Date: Sun, 20 Apr 2025 03:32:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] vhost/net: Defer TX queue re-enable until
 after sendmsg
Message-ID: <20250420033135-mutt-send-email-mst@kernel.org>
References: <20250420010518.2842335-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420010518.2842335-1-jon@nutanix.com>

On Sat, Apr 19, 2025 at 06:05:18PM -0700, Jon Kohler wrote:
> In handle_tx_copy, TX batching processes packets below ~PAGE_SIZE and
> batches up to 64 messages before calling sock->sendmsg.
> 
> Currently, when there are no more messages on the ring to dequeue,
> handle_tx_copy re-enables kicks on the ring *before* firing off the
> batch sendmsg. However, sock->sendmsg incurs a non-zero delay,
> especially if it needs to wake up a thread (e.g., another vhost worker).
> 
> If the guest submits additional messages immediately after the last ring
> check and disablement, it triggers an EPT_MISCONFIG vmexit to attempt to
> kick the vhost worker. This may happen while the worker is still
> processing the sendmsg, leading to wasteful exit(s).
> 
> This is particularly problematic for single-threaded guest submission
> threads, as they must exit, wait for the exit to be processed
> (potentially involving a TTWU), and then resume.
> 
> In scenarios like a constant stream of UDP messages, this results in a
> sawtooth pattern where the submitter frequently vmexits, and the
> vhost-net worker alternates between sleeping and waking.
> 
> A common solution is to configure vhost-net busy polling via userspace
> (e.g., qemu poll-us). However, treating the sendmsg as the "busy"
> period by keeping kicks disabled during the final sendmsg and
> performing one additional ring check afterward provides a significant
> performance improvement without any excess busy poll cycles.
> 
> If messages are found in the ring after the final sendmsg, requeue the
> TX handler. This ensures fairness for the RX handler and allows
> vhost_run_work_list to cond_resched() as needed.
> 
> Test Case
>     TX VM: taskset -c 2 iperf3  -c rx-ip-here -t 60 -p 5200 -b 0 -u -i 5
>     RX VM: taskset -c 2 iperf3 -s -p 5200 -D
>     6.12.0, each worker backed by tun interface with IFF_NAPI setup.
>     Note: TCP side is largely unchanged as that was copy bound
> 
> 6.12.0 unpatched
>     EPT_MISCONFIG/second: 5411
>     Datagrams/second: ~382k
>     Interval         Transfer     Bitrate         Lost/Total Datagrams
>     0.00-30.00  sec  15.5 GBytes  4.43 Gbits/sec  0/11481630 (0%)  sender
> 
> 6.12.0 patched
>     EPT_MISCONFIG/second: 58 (~93x reduction)
>     Datagrams/second: ~650k  (~1.7x increase)
>     Interval         Transfer     Bitrate         Lost/Total Datagrams
>     0.00-30.00  sec  26.4 GBytes  7.55 Gbits/sec  0/19554720 (0%)  sender
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>

sounds like the right approach.

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---


in the future, pls put the changelog here as you progress v1->v2->v3.
Thanks!

>  drivers/vhost/net.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index b9b9e9d40951..9b04025eea66 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -769,13 +769,17 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			break;
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
> +			/* If interrupted while doing busy polling, requeue
> +			 * the handler to be fair handle_rx as well as other
> +			 * tasks waiting on cpu
> +			 */
>  			if (unlikely(busyloop_intr)) {
>  				vhost_poll_queue(&vq->poll);
> -			} else if (unlikely(vhost_enable_notify(&net->dev,
> -								vq))) {
> -				vhost_disable_notify(&net->dev, vq);
> -				continue;
>  			}
> +			/* Kicks are disabled at this point, break loop and
> +			 * process any remaining batched packets. Queue will
> +			 * be re-enabled afterwards.
> +			 */
>  			break;
>  		}
>  
> @@ -825,7 +829,14 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		++nvq->done_idx;
>  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
>  
> +	/* Kicks are still disabled, dispatch any remaining batched msgs. */
>  	vhost_tx_batch(net, nvq, sock, &msg);
> +
> +	/* All of our work has been completed; however, before leaving the
> +	 * TX handler, do one last check for work, and requeue handler if
> +	 * necessary. If there is no work, queue will be reenabled.
> +	 */
> +	vhost_net_busy_poll_try_queue(net, vq);
>  }
>  
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> -- 
> 2.43.0


