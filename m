Return-Path: <netdev+bounces-299843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zHH1F/JLMWrugAUAu9opvQ
	(envelope-from <netdev+bounces-299843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:13:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90E468FC9E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:13:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=redhat.com header.s=mimecast20190719 header.b=izDkDBJ7;
	dkim=fail ("headers rsa verify failed") header.d=redhat.com header.s=google header.b=qfBFySeP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299843-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299843-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=redhat.com (policy=quarantine);
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 862FF3028EE6
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362603624D4;
	Tue, 16 Jun 2026 13:00:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418636493F
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:00:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614804; cv=none; b=Wsw9ivWc9jMyXtZeMOHhdU3OIuyiAMm951yazbIhy2NrU4IkYnQSPfvWWh4T96SEv1AQA7bjfC+USfSIECPe+eKVVLpzmz6tRM0q5QvgOlzqmy8GKGC6Yt8boqLzBz8AuC8gHGFhXgAICXcvJKeF832LcSxTM2E2E5q4jpwbdcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614804; c=relaxed/simple;
	bh=bhB8cqYkdx99HnRuLaoyAkAfNvz4q6LWBo4ONFNXjmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLPG7uH54ZBu76ny+S6Mar9jYNxb5nKpRE4+bc2IHrCE1URN/g9CzvI+ukqXZlL728g7AM6PAkkkofVjMCMJM17mi4SjOjfxLVsNGjDFrRPcEDLNTlpZlOUc5UYrOAphg5lYwoO6gAHPiJyGPW92NZc85lWnlzv856z7yppWlDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izDkDBJ7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qfBFySeP; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781614801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVj9gc1a5EiZ8GlGp7l1tQy1b06455G3XK/4iEWItig=;
	b=izDkDBJ7Z9CQ+t9sVivC6Fwt7u0570xgxg57lwKfLkuRLZVXR7g/lOyLyRryNTXuBpzFn8
	Dpr6Rb3M93oiOWlRL2ymPSwCcImleQkcSAKSx+mrqlt5ciA2q9kRjAFZkrlHyPiTqXe2Ws
	Aw74I8u0mEIbjU253CKkjOkysy7lWxE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-KjKpuEWjPYqDv66LG0vPcQ-1; Tue, 16 Jun 2026 08:59:59 -0400
X-MC-Unique: KjKpuEWjPYqDv66LG0vPcQ-1
X-Mimecast-MFC-AGG-ID: KjKpuEWjPYqDv66LG0vPcQ_1781614798
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso29363245e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781614798; x=1782219598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVj9gc1a5EiZ8GlGp7l1tQy1b06455G3XK/4iEWItig=;
        b=qfBFySePK3ONJcI32lzd6ju6Dl/CDZqDAPPuyGNVdApEwfgB/jNpbeJV9aLfTDz75T
         tdKM7IyQoIJmGwAzMsnsJMldk1OYaan/JX9/sKGbHt3gnwcFWJuPUV7GnoUITZoaR8u+
         y4NXAiiANlwJ/NpvXrLn3+QDzpy6YBVBWk/vZRj5K8gC8KFUuMupwncPJbJn3XMez4ik
         XKvZzJsDmweg19Kd1SYCBLjQWfpToum/id/FDZD97zHiu7+d2BkYkIrLJb2hbw5RT2lX
         T7mvx00958dDF5jkcIAgJsibp8wuGmZMlefkkZE8rnCXMTWSFA+SsW8qkHrbIh3O7yCP
         BaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781614798; x=1782219598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVj9gc1a5EiZ8GlGp7l1tQy1b06455G3XK/4iEWItig=;
        b=LRvBIrYPusTDX9QahZEF6xVtvsMW0cDBeaO18CLvFv5RTysEdzBi+IkfpUw/iRqbnI
         89v2XlxuRbh4M9z2eZCMhirPvo/7VetnSetmC4duB/h+/SNbN7+359AK9Q7IDTgGLKXs
         wzBC0Pz20Io9LLQQ6V2x7d+XeLLWP68fKCEFCMKxmRBzE21FrG9K/WfWax9zMKgvOd3e
         vYJ5sJR8shfAt8b/dn+Zxzj5zuRsPUu90SIniOSdDRISR9hLNLkyAGvdGV+t/tHxq8Av
         Ftk5oEi+in+N9ck93m+tpBQ3QH79rRtO6xbsBz2reyfiZ+HBtNm2za44w8rrq5LWTI8u
         ojCg==
X-Gm-Message-State: AOJu0Yyr/leyTROTrMJWLayKWXXRuRwrqCOzmm0WXqpylx1B35k3VtZc
	NtqJT8ItQemGsBiopRBDye1/IpwlXg4n+8cS3r+6LMFMfxFkhExIhHoqf1GZdLUIV7NDDN5usos
	yCOhB6CbiyxieC1YccrGD7i1AWeSKOCzLssQtaOtSE2SWgdKdaPaCkUX6Cg==
X-Gm-Gg: Acq92OEzEuRsMbwKXCOjnTXLoC71ATKpx1ThejVB+4/Q7jWzQl+x6vTDt3wTNupuxHe
	K0rPQXaGVSmDDmGBwsavh2s/45zus6rNauXab8qinHbALuH1rRoqRy1jxvXpWdd5Q/HUAS6hybo
	e9zQ76Y9uCz42Xa6Bp4QoPm6t2orpTcRjoieFc9TprE/U+mJi7+LyzJ8rEpgocuPcnV5Kuh75lj
	sQqBbrIxT4+6I9K9PIFsIcLqDZWZzMvElTd5JekaozYgUgONsI+iHccQfPP31mnXtvlYLjZe9i7
	wO5MGf9MUOak1VpYQk5Cks/Z+mWaipD1cwvZsazakE+scYBGmmE6OdXO/ap35PK7hPD1M+/K+Ci
	7WbqgEEC/Loo9xKTThCWS2nH44XUfR2OvUw0yg8H1U8ms7ohddsrY/5Zr4mfLgTQzmdeyLsc=
X-Received: by 2002:a05:600c:4713:b0:491:7325:39c4 with SMTP id 5b1f17b1804b1-49220164d3bmr190086625e9.34.1781614797531;
        Tue, 16 Jun 2026 05:59:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4713:b0:491:7325:39c4 with SMTP id 5b1f17b1804b1-49220164d3bmr190084565e9.34.1781614795388;
        Tue, 16 Jun 2026 05:59:55 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa97a07sm131444255e9.14.2026.06.16.05.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:59:54 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:59:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Octavian Purdila <tavip@google.com>,
	g@sgarzare-redhat.smtp.subspace.kernel.org
Cc: netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2 2/2] vsock/virtio: restore msg_iter on
 transmission failure
Message-ID: <ajFEpMnHsxAYJSOa@sgarzare-redhat>
References: <20260613000953.467473-1-tavip@google.com>
 <20260613000953.467473-3-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260613000953.467473-3-tavip@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[redhat.com : SPF not aligned (relaxed),quarantine];
	R_DKIM_REJECT(1.00)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299843-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:tavip@google.com,m:g@sgarzare-redhat.smtp.subspace.kernel.org,m:netdev@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:akpm@linux-foundation.org,m:avkrasnov@salutedevices.com,m:davem@davemloft.net,m:edumazet@google.com,m:eperezma@redhat.com,m:kuba@kernel.org,m:jasowang@redhat.com,m:kvm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:pabeni@redhat.com,m:horms@kernel.org,m:stefanha@redhat.com,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,m:syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:-];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,28e5f3d207b14bae122a];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email,sgarzare-redhat:mid,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A90E468FC9E

On Sat, Jun 13, 2026 at 12:09:53AM +0000, Octavian Purdila wrote:
>When transmission fails in virtio_transport_send_pkt_info, the msg_iter
>might have been partially advanced. If we don't restore it, the next
>attempt to send data will use an incorrect iterator state, leading to
>desync and warnings like "send_pkt() returns 0, but X expected".
>
>Specifically, this can happen in the following scenario, triggered by
>the syzkaller repro:
>
>1. A write-only VMA (PROT_WRITE only) is partially populated by a
>   prior TUN write that failed with -EIO but still faulted in some
>   pages).
>2. A vsock sendmmsg call with MSG_ZEROCOPY requests transmission of a
>   buffer from this VMA.
>3. The first packet (64KB) is sent successfully because the pages are
>   populated.
>4. The second packet allocation fails because GUP fast pins the first page
>   but GUP slow fails on the next unpopulated page due to PROT_WRITE-only
>   permissions.
>5. The iterator is advanced by the partially successful GUP (68KB total
>   advanced: 64KB from first packet + 4KB from second), but the send loop
>   breaks and only reports 64KB sent. This creates a 4KB desync.
>6. The next retry starts with a non-zero iov_offset, disabling zerocopy
>   and falling back to copy mode.
>7. In copy mode, the transmission succeeds for the next packets but
>   exhausts the iterator early because of the desync.
>8. The final retry sees an empty iterator but zerocopy is re-enabled
>   (offset resets). It attempts to send the remaining bytes with zerocopy
>   but pins 0 pages, creating an empty packet.
>9. The transport sends the empty packet, triggering the warning because
>   the returned bytes (header only) do not match the expected payload size.
>10. The loop continues to spin, allocating ubuf_info each time, eventually
>    exhausting sysctl_optmem_max and returning -ENOMEM to userspace.
>
>Restore msg_iter to its original state before the packet allocation
>and transmission attempt if they fail.
>
>Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
>Reported-by: syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=28e5f3d207b14bae122a
>Assisted-by: gemini:gemini-3.1-pro
>Signed-off-by: Octavian Purdila <tavip@google.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)

Thanks, looks much better to me now!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


