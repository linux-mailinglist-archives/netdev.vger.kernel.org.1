Return-Path: <netdev+bounces-149384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5AE9E55DA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B424164DA3
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33136218ABC;
	Thu,  5 Dec 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="V8tgxnuV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E115218AAB
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403238; cv=none; b=Y/ZnimAyO9RMZBLWoRg8syRK/qLeusg0Yk6439p/sM55l+t5hTOb9Yh5JhQLQ6QZZaU3wklrO3yHrJ9YLXTjRRmqutEndFJsgbB/Rn/XEwjjyDUI0oDIWbXCpKkydaCG/3NBl/bhHG3RGtlTeJK2Cy4/PU2hxPDXKXGTq3hu9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403238; c=relaxed/simple;
	bh=JZWxDg6kLZ0bFvcAVD+a3fOTrGu99x0LQws4omTlL0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPZffSZ6nmVffb+exqeghlYXsUAPTDh9eqF6mDY0MdqCHCPrMHX0z1Inc06bv7pQW5D+fCNkGkouMyOEKNkHfIJi0mTW0dXdG7WGINm+NYppzy5ao1lG4EBLIUsr2VcExYUm36hq3RR5BTANqYlWIMjzCWjzRJskct9casD/eH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=V8tgxnuV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CBC183F182
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 12:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733403232;
	bh=FUPqE51TLvEDtsqOtCI9i9XXbeFVSmPyWNWK1a6nR9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=V8tgxnuVMGhqBI7cS51lH9AOTzm58sThQ4pWSkjdvgwxDz7LKMI7auV4NFxhDqnAH
	 OnaOXDcqkqQbf7WOpihH/XIe8wAf6FcArXpRgbC99RsMnXg9kJxr1vbd3drfto4Q3y
	 JZMse6qpdowiLZn5zPMJuezZY5JeAOcUsKp48RE5xqOcnWERlyeQEA4dAdDxGfj+Ub
	 Kc8xaVgSMi0hKYVGzKiV+ByhHOA/5dYZjKkJ85n4QM7dKevV0p6+/XlbU1ePLisn1E
	 ND5h3rCSe0wxiBB3gBaKa8vMZPKcBOuAagVABlEQ3E8S5LvHlqsYbybTqbqKKUOKwT
	 I3Ania1gGZOhA==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7fcff306a20so1660149a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 04:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733403231; x=1734008031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUPqE51TLvEDtsqOtCI9i9XXbeFVSmPyWNWK1a6nR9k=;
        b=R/kqDp0LUSN8/1qMsDNn4qOTnSuVJMTgUJ9Pp4ZILc9RH1s4Ml8htnTsJUnwaekSOl
         R5X+vFnCk8cCqmXbTzoCDVZrZwAV6d97T6yHayM77Ix5EoXF9q/kw23xYro5fPDaaUIc
         dunZU1hJAze/NyZuGjHftwMUx1h65YPQf5z598iltrHX5hz+el4U+ZdtLuyPQC1DUx5S
         xQriT7SoRhMKIswQwpJGIZHdPL7RlQiQUfbJktYeBkyZFV06iqfa6f9LvNeovjSs2CQq
         htv/0gTgfruOvR6JBVpz727AxtlKwvVR5FhlAgTlp62WUfa2OU/R7H5Fi83f3YE4bnx7
         M3vg==
X-Forwarded-Encrypted: i=1; AJvYcCW8pXaqjwxVijkowF9/gYOuMjnwtRNY0AV1h5KR9mY2koBdpEaMBbco8pBuVO6fVeTxeUzrbo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfHXqgCdtVtgIl/ZOJRFj4x3zVkiCb4JyiLVzDoh8IiQKR4GkU
	D1JZ+jqT7tiVQrSua/oqa6FMon2WsFFWAmttVNCX7pussTf2MeK8xOnhZ7iX4e2zAjnT85MvmUS
	V/k/01jvkXj4VcdJVqYpOhuWa8CLe90t38Lqxn/q9Xr+hpgvz5S+CAHKXU2JzKGmblFNSYg==
X-Gm-Gg: ASbGncvPqtcYut9WeFqbIr77C8NdcWzwG4rePlpL1t18C0idPTSCKbWDWosNHWBpQ65
	NRXUlm8Ysh5osV1s0NW1PO4AjW+NLtDEoxDG/7cJko4zvoGVD9vcVbqmUZ+UMMoBaZCtZim6HSf
	xPiSUBW5z0iKzihSV5MYNPB6D69nbaY8m6MA68rRct71AeUc+Ip5DzVGlzzuZEgEIdB1bh4K4Aq
	qEr7LSELroUYJoFQPhLB3faZsArEeIrflAEnGx5xOwo3t5CrjA=
X-Received: by 2002:a05:6a20:9186:b0:1d9:ec2:c87b with SMTP id adf61e73a8af0-1e17d3841f3mr4662268637.9.1733403231228;
        Thu, 05 Dec 2024 04:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmNoiRxBOlLsxc22EXT6uQ0ZpleA21ZKP6ZYanOZreHBwMPSzZzR3LFylnFh324PSe+sabHw==
X-Received: by 2002:a05:6a20:9186:b0:1d9:ec2:c87b with SMTP id adf61e73a8af0-1e17d3841f3mr4662236637.9.1733403230902;
        Thu, 05 Dec 2024 04:53:50 -0800 (PST)
Received: from localhost ([240f:74:7be:1:d88b:a41e:6f7b:abf])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156b7964sm1080721a12.18.2024.12.05.04.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:53:50 -0800 (PST)
Date: Thu, 5 Dec 2024 21:53:49 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/7] virtio_net: introduce
 virtnet_sq_free_unused_buf_done()
Message-ID: <42s4swjiewp7fv2st6i6vzs5dlcah5r5rupl57s75hiqeds7hl@fu4oqhjm7cxc>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
 <20241204050724.307544-4-koichiro.den@canonical.com>
 <20241205054009-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205054009-mutt-send-email-mst@kernel.org>

On Thu, Dec 05, 2024 at 05:40:33AM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 04, 2024 at 02:07:20PM +0900, Koichiro Den wrote:
> > This will be used in the following commits, to ensure DQL reset occurs
> > iff. all unused buffers are actually recycled.
> > 
> > Cc: <stable@vger.kernel.org> # v6.11+
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> 
> to avoid adding an unused function, squash with a patch that uses it.

I originally seperated this out because some were supposed to land stable
tree while others not, and this was the common prerequisite. However, this
can be squahsed with [5/7] regardless of that, and should be done so as you
pointed out.

I'll do so and send v4 later, thanks for the review.

> 
> 
> > ---
> >  drivers/net/virtio_net.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1b7a85e75e14..b3cbbd8052e4 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -503,6 +503,7 @@ struct virtio_net_common_hdr {
> >  static struct virtio_net_common_hdr xsk_hdr;
> >  
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> > +static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
> >  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> >  			       struct net_device *dev,
> >  			       unsigned int *xdp_xmit,
> > @@ -6233,6 +6234,14 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  	}
> >  }
> >  
> > +static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq)
> > +{
> > +	struct virtnet_info *vi = vq->vdev->priv;
> > +	int i = vq2txq(vq);
> > +
> > +	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
> > +}
> > +
> >  static void free_unused_bufs(struct virtnet_info *vi)
> >  {
> >  	void *buf;
> > -- 
> > 2.43.0
> 

