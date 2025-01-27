Return-Path: <netdev+bounces-161165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDD9A1DB97
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 18:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26E83A41C6
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2624F18A93C;
	Mon, 27 Jan 2025 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="TK2+zEPJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3017C224
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000333; cv=none; b=Q1+CHuYixhpI+7WYG0+ZB7pZHBi35wTDWqYg+URuLElnBbJgekjERbZ3PEcOKTzLUOD0+iNeBtzfrWCSJfPcceq4fmxo2THjKuVvnqOJrYaK+IrpgzNrWyn3fgUhXQ/fXSNN4PX8kbv+CVuAcI49yr5MnTbaJ7wGdHQ1sfaOcDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000333; c=relaxed/simple;
	bh=LxEsmRsmjKHW34dRdKZW5bHq9jQ7yg1Weh7p5a1U+Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo2L7ISNw8Q18inNM2ex1KBaqsphNqwVcKckeACz+S45eUZz3jHyrQ7O+80msZ9QNLuV2aJsWYi56MxylVssysNlpP4W1JlCOj46iFqHwfXpC93utGl5QlvvMe52iV1q4v02loFKinrBKv+B+n8GUNEDFTvYJZH3H3IsPL5cM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=TK2+zEPJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46901d01355so46741911cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 09:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738000330; x=1738605130; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q99Pp2pABF1FmwKx8NKe2Hs1j8kidoliyjyY4l+h5dI=;
        b=TK2+zEPJUo/ZbPum3JnNF5w+ooEYgZixiKzzNpya3ToPni9gq5+tY9JOnzDWsRczRn
         K7DgkrW8NqYz/nq+WOOF7lnec36q4nrqXk54jy0E3thAdzGnALyrffejrrQ9GZY25Oa5
         75a8vFkvdGkjsZGphKV2piDWmjiUChD2Ji5zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738000330; x=1738605130;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q99Pp2pABF1FmwKx8NKe2Hs1j8kidoliyjyY4l+h5dI=;
        b=Z4riXTJ2qwKsyfiq4w1YNzu2KbVDWTuhIzZffFN3z9cOVVsExT1PiTEO3gjuah7hTf
         0Dy7eJGJd+U8Ty4oYFiroHhJ0B0j0BK55tkMpxBPaj5MESerqcno0ZWZ2HNzNns0QRSx
         OOap6ciwrg3+NGgXqo1YEOmuP9gUgmPX3bUedNeUp05gxapCTX9erYAbiVB1JOn52JYs
         hgGzbrPv0Sp1RAseP8JXV3J8WTdWI6j/9uALILxMp4/G9q2ayGZCD5Ofzn8L1n+mgakn
         jpenk869eaBDOaHS2S+8nQUysquj08eS24I9rHzxTlGBb98GaUMCoXc7gBscliLSlwm/
         wgKQ==
X-Gm-Message-State: AOJu0Yzi94p918DyQhwHcl7Qv9urP2lrgq9Zo/iWr33pO8lQ/Ls0wUk4
	7SA7iMeWtUY/PQbr+uMITD6Sl8H6n9Jspkw7is6raz6XWAB4KrflpSwljskuwFQ=
X-Gm-Gg: ASbGncu02jS5cu12t3BdYFLu5lArU+63CsParVfGYURGVw2VpzbyQS9dCMppd9sqWJU
	5z1wo0syW3nOKMSsTj2f4DzyM4dKI9oPAqOF0+ByFgmjurSz3bBZdw6Q1Lxq0sl6wHaxHw2Fccf
	zK/16G0jZGqBR8pBIFSKLDLeEta8Py9DR/Jd1XAzJSTKy37bllyI9YDphun/n2tjKxVx6YQlYDC
	OuWzAvZrg4K1DkGGzaG3QyCw2l5fAqZkmIKLvv6kYMyVF9AlHxKY/r/Z7NCekG5QLYZRMnMl29P
	XsweGYq0Nd0ZVhGtDHJDpL9lCV/CbgikyXnD6pjRXt82fsD+
X-Google-Smtp-Source: AGHT+IGAD4PkQm++BE7tseFMIEH06/qp1iRxk/uszlis0YUNIMYMn61cw2qytsrr7qBhUDqEPk+f0Q==
X-Received: by 2002:a05:622a:58e:b0:467:6cd9:3093 with SMTP id d75a77b69052e-46e12bc2747mr611419831cf.46.1738000329986;
        Mon, 27 Jan 2025 09:52:09 -0800 (PST)
Received: from LQ3V64L9R2 (ip-185-104-139-70.ptr.icomera.net. [185.104.139.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e205136b0dsm36682946d6.1.2025.01.27.09.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 09:52:09 -0800 (PST)
Date: Mon, 27 Jan 2025 12:52:06 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, gerhard@engleder-embedded.com,
	leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue
 mapping
Message-ID: <Z5fHxutzfsNMoLxS@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250121191047.269844-1-jdamato@fastly.com>
 <20250121191047.269844-3-jdamato@fastly.com>
 <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
 <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
 <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
 <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
 <CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>
 <Z5P10c-gbVmXZne2@LQ3V64L9R2>
 <CACGkMEv4bamNB0KGeZqzuJRazTtwHOEvH2rHamqRr1s90FQ2Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv4bamNB0KGeZqzuJRazTtwHOEvH2rHamqRr1s90FQ2Vg@mail.gmail.com>

On Sun, Jan 26, 2025 at 04:04:02PM +0800, Jason Wang wrote:
> On Sat, Jan 25, 2025 at 4:19 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Fri, Jan 24, 2025 at 09:14:54AM +0800, Jason Wang wrote:
> > > On Thu, Jan 23, 2025 at 10:47 AM Joe Damato <jdamato@fastly.com> wrote:
> > > >
> > > > On Thu, Jan 23, 2025 at 10:40:43AM +0800, Jason Wang wrote:
> > > > > On Thu, Jan 23, 2025 at 1:41 AM Joe Damato <jdamato@fastly.com> wrote:
> > > > > >
> > > > > > On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> > > > > > > On Wed, Jan 22, 2025 at 3:11 AM Joe Damato <jdamato@fastly.com> wrote:

[...]

> > > > > > > >
> > > > > > > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > > > > > > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > > > > > > +                                  struct napi_struct *napi)
> > > > > > > >  {
> > > > > > > >         napi_enable(napi);
> > > > > > >
> > > > > > > Nit: it might be better to not have this helper to avoid a misuse of
> > > > > > > this function directly.
> > > > > >
> > > > > > Sorry, I'm probably missing something here.
> > > > > >
> > > > > > Both virtnet_napi_enable and virtnet_napi_tx_enable need the logic
> > > > > > in virtnet_napi_do_enable.
> > > > > >
> > > > > > Are you suggesting that I remove virtnet_napi_do_enable and repeat
> > > > > > the block of code in there twice (in virtnet_napi_enable and
> > > > > > virtnet_napi_tx_enable)?
> > > > >
> > > > > I think I miss something here, it looks like virtnet_napi_tx_enable()
> > > > > calls virtnet_napi_do_enable() directly.
> > > > >
> > > > > I would like to know why we don't call netif_queue_set_napi() for TX NAPI here?
> > > >
> > > > Please see both the cover letter and the commit message of the next
> > > > commit which addresses this question.
> > > >
> > > > TX-only NAPIs do not have NAPI IDs so there is nothing to map.
> > >
> > > Interesting, but I have more questions
> > >
> > > 1) why need a driver to know the NAPI implementation like this?
> >
> > I'm not sure I understand the question, but I'll try to give an
> > answer and please let me know if you have another question.
> >
> > Mapping the NAPI IDs to queue IDs is useful for applications that
> > use epoll based busy polling (which relies on the NAPI ID, see also
> > SO_INCOMING_NAPI_ID and [1]), IRQ suspension [2], and generally
> > per-NAPI configuration [3].
> >
> > Without this code added to the driver, the user application can get
> > the NAPI ID of an incoming connection, but has no way to know which
> > queue (or NIC) that NAPI ID is associated with or to set per-NAPI
> > configuration settings.
> >
> > [1]: https://lore.kernel.org/all/20240213061652.6342-1-jdamato@fastly.com/
> > [2]: https://lore.kernel.org/netdev/20241109050245.191288-5-jdamato@fastly.com/T/
> > [3]: https://lore.kernel.org/lkml/20241011184527.16393-1-jdamato@fastly.com/
> 
> Yes, exactly. Sorry for being unclear, what I want to ask is actually:
> 
> 1) TX NAPI doesn't have a NAPI ID, this seems more like a NAPI
> implementation details which should be hidden from the driver.
> 2) If 1 is true, in the netif_queue_set_napi(), should it be better to
> add and check for whether or not NAPI has an ID and return early if it
> doesn't have one
> 3) Then driver doesn't need to know NAPI implementation details like
> NAPI stuffs?

Sorry it just feels like this conversation is getting off track.

This change is about mapping virtio_net RX queues to NAPI IDs to
allow for RX busy polling, per-NAPI config settings, etc.

If you try to use netif_queue_set_napi with a TX-only NAPI, it will
set the NAPI ID to 0.

I already addressed this in the cover letter, would you mind
carefully re-reading my cover letter and commit messages?

If your main concern is that you want me to call
netif_queue_set_napi for TX-only NAPIs in addition to the RX NAPIs
in virtio_net, I can do that and resend an RFC.

In that case, the output will show "0" for NAPI ID for the TX-only
NAPIs. See the commit message of patch 3 and imagine that the output
shows this instead:

$ ./tools/net/ynl/pyynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 0, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 0, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 0, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 0, 'type': 'tx'}]

If in the future the TX-only NAPIs get NAPI IDs, then nothing would
need to be updated in the driver and the NAPI IDs would "just work"
and appear.

> >
> > > 2) does NAPI know (or why it needs to know) whether or not it's a TX
> > > or not? I only see the following code in napi_hash_add():
> >
> > Note that I did not write the original implementation of NAPI IDs or
> > epoll-based busy poll, so I can only comment on what I know :)
> >
> > I don't know why TX-only NAPIs do not have NAPI IDs. My guess is
> > that in the original implementation, the code was designed only for
> > RX busy polling, so TX-only NAPIs were not assigned NAPI IDs.
> >
> > Perhaps in the future, TX-only NAPIs will be assigned NAPI IDs, but
> > currently they do not have NAPI IDs.
> 
> Jakub, could you please help to clarify this part?

Can you please explain what part needs clarification?

Regardless of TX-only NAPIs, we can still set NAPI IDs for
virtio_net RX queues and that would be immensely useful for users.

There's two options for virtio_net as I've outlined above and in my
cover letter and commit messages:

1. This implementation as-is. Then if one day in the future
   TX-only NAPIs get NAPI IDs, this driver (and others like mlx4)
   can be updated.

- OR -

2. Calling netif_queue_set_napi for all NAPIs, which results in the
   TX-only NAPIs displaying "0" as shown above.

Please let me know which option you'd like to see; I don't have a
preference, I just want to get support for this API in virtio_net.

> >
> > > static void napi_hash_add(struct napi_struct *napi)
> > > {
> > >         unsigned long flags;
> > >
> > >         if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
> > >                 return;
> > >
> > > ...
> > >
> > >         __napi_hash_add_with_id(napi, napi_gen_id);
> > >
> > >         spin_unlock_irqrestore(&napi_hash_lock, flags);
> > > }
> > >
> > > It seems it only matters with NAPI_STATE_NO_BUSY_POLL.
> > >
> > > And if NAPI knows everything, should it be better to just do the
> > > linking in napi_enable/disable() instead of letting each driver do it
> > > by itself?
> >
> > It would be nice if this were possible, I agree. Perhaps in the
> > future some work could be done to make this possible.
> >
> > I believe that this is not currently possible because the NAPI does
> > not know which queue ID it is associated with. That mapping of which
> > queue is associated with which NAPI is established in patch 3
> > (please see the commit message of patch 3 to see an example of the
> > output).
> >
> > The driver knows both the queue ID and the NAPI for that queue, so
> > the mapping can be established only by the driver.
> >
> > Let me know if that helps.
> 
> Yes, definitely.
> 
> Let's see Jakub's comment.

As mentioned above, I'm not sure if we need to worry about TX-only
NAPIs getting NAPI IDs.

That seems pretty unrelated to this change as I've explained above.

