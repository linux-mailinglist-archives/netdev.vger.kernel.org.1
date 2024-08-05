Return-Path: <netdev+bounces-115829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1A5947F02
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2951282AC9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198421514E1;
	Mon,  5 Aug 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnLnyvFM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7A15B562
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874264; cv=none; b=bwvwrbIMkcrp1g7lgV4N3M0vm/7vWtH5b8eY0mrj2AZY8ewvTu+UJSm2fTZ9s3N4FQC7l//egzphqP4yi3M08u6vSWfEUZ00rGdfntuuibJH+2iaFncAR8X31BllErRSg2JtgPHWSTn/j+1YxBuvOrDUdTE1NjT1PmNhiCSVN/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874264; c=relaxed/simple;
	bh=TAnYIadcwF9pivb5TZWzC8nGHHVUgFgfgzZrf4jObnA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fweMvWz3WYVeYS8xGzYHghBg/Fw0qKU3XlHrgtKZQRSQbqvu0MHEIqc3zhiWX3hTXHDcEIRCFaYg3ajmwaX3PARLlqabN/End+dqAg1HwriLhCKmZZqKxUlQZlBzj6W2jhoSd1vQ+oxRwKiBKESOwOMVBiBo6/EFIheq5pVkmNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnLnyvFM; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b79293a858so54004016d6.3
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 09:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722874261; x=1723479061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUJsEILMDDuw2q0kDNRVBSRSgTiEXgha8tMv2SJ7BAw=;
        b=dnLnyvFMB39Qwy4zpCcAuBL20K42FNOOPSmBtPQfeXpfTGdGOuA+XxRWP7jgM4tuVw
         LlhqvKmfCt0G3zfdk2ZrHfqj3mYaulWBNMbx4P9CJo3AQwEmgu1EyDgFanHFtkq0kvVE
         shB4/WItntujgTIgvQUhHbolv1/r/6YyfgXR6M/BA7PPyWU+8AM++FnOlln3H4Kf6wWv
         ZfVo74DLGum2U2hGeeS5lh5B3rF0T+Cex5cGBH2YaIbAsvSZfeMORoEeWv4Je2NZNWCd
         DWU2NIgrRK+7DHgvZIlcPDyY8TlMLYzgdrl659LW6BKEizKgD/qljMl0F/P/ntVYHXyQ
         fGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722874261; x=1723479061;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hUJsEILMDDuw2q0kDNRVBSRSgTiEXgha8tMv2SJ7BAw=;
        b=fvAS9trxSrdlSfMtCAjdQVc0qs0mPrRRoFJFK5GIqCjFjtNveERXyOngQIEc+TR81l
         zV7/4sdbZ+m4mI+7BxOoGAvzvxufO322MwTXLgcLQDTfPZ7UuKaOdr33rFuxdAScH2Fg
         OXGKk9VovdxvPyl+jfzWV/7k2mwcTbwnC9boal15flYF01z/3zRghflAPxwwiuozuVQa
         5eoUouNbtfNEPKQCWg3LH9HgdsW2E9OdEwPGh7t2mfMnZEyU2gy17f4VRjHEZtyRGCN/
         98OQ8Px2xMIx1LJhPzgIf6DV4tdUfGGgawinWajH+crOfhApg/TgnFWuZw+8FSFeU2Q3
         BiQQ==
X-Gm-Message-State: AOJu0Yx460yo0rOL1iZc3b8Dxc7Po8XSqOL+fBSIzRnwrFLZFtvv8QjH
	ll67Fm4O2uiUfh5HMR+0o75OSoNGUrqUBhegyhNkHX78wS9uvwGm
X-Google-Smtp-Source: AGHT+IEIt/6AFfndGIQMWiJ8k4T1myM0Rg8XyhJ1XwRYFBOX7bh8IJiuFsN/kN2dUu8U0MYBZeGFdQ==
X-Received: by 2002:a05:6214:5d0b:b0:6b5:fa20:9b3d with SMTP id 6a1803df08f44-6bb98495747mr149968576d6.46.1722874261272;
        Mon, 05 Aug 2024 09:11:01 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b82d6sm36673996d6.69.2024.08.05.09.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:11:00 -0700 (PDT)
Date: Mon, 05 Aug 2024 12:11:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com, 
 syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Message-ID: <66b0f99413948_2fa9852946@willemb.c.googlers.com.notmuch>
In-Reply-To: <8734njyn8j.fsf@cloudflare.com>
References: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
 <20240801-udp-gso-egress-from-tunnel-v2-1-9a2af2f15d8d@cloudflare.com>
 <CAF=yD-JaeHASZacOPk=k2gzpfY7OzMwDPr99FMfthMS0w9S7bA@mail.gmail.com>
 <87ed73z3oe.fsf@cloudflare.com>
 <66b0e0d3c2119_2f5edf294c1@willemb.c.googlers.com.notmuch>
 <8734njyn8j.fsf@cloudflare.com>
Subject: Re: [PATCH net v2 1/2] gso: Skip bad offload detection when device
 supports requested GSO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> On Mon, Aug 05, 2024 at 10:25 AM -04, Willem de Bruijn wrote:
> > Jakub Sitnicki wrote:
> >> On Thu, Aug 01, 2024 at 03:13 PM -04, Willem de Bruijn wrote:
> 
> [...]
> 
> >> > It's a bit odd, in that the ip_summed == CHECKSUM_NONE ends up just
> >> > being ignored and devices are trusted to always be able to checksum
> >> > offload when they can segment offload -- even when the device does not
> >> > advertise checksum offload.
> >> >
> >> > I think we should have a follow-on that makes advertising
> >> > NETIF_F_GSO_UDP_L4 dependent on having at least one of the
> >> > NETIF_F_*_CSUM bits set (handwaving over what happens when only
> >> > advertising NETIF_F_IP_CSUM or NETIF_F_IPV6_CSUM).
> >> 
> >> I agree. I've also gained some clarity as to how the fix should
> >> look. Let's circle back to it, if we still think it's relevant once we
> >> hash out the fix.
> >> 
> >> After spending some quality time debugging the addded regression test
> >> [1], I've realized this fix is wrong.
> >> 
> >> You see, with commit 10154dbded6d ("udp: Allow GSO transmit from devices
> >> with no checksum offload"), I've opened up the UDP_SEGMENT API to two
> >> uses, which I think should not be allowed:
> >> 
> >> 1. Hardware USO for IPv6 dgrams with extension headers
> >> 
> >> Previously that led to -EIO, because __ip6_append_data won't annotate
> >> such packets as CHECKSUM_PARTIAL.
> >> 
> >> I'm guessing that we do this because some drivers that advertise csum
> >> offload can't actually handle checksumming when extension headers are
> >> present.
> >> 
> >> Extension headers are not part of IPv6 pseudo header, but who knows what
> >> limitations NIC firmwares have.
> >> 
> >> Either way, changing it just like that sounds risky, so I think we need
> >> to fall back to software USO with software checksum in this case.
> >> 
> >> Alternatively, we could catch it in the udp layer and error out with EIO
> >> as ealier. But that shifts some burden onto the user space (detect and
> >> segment before sendmsg()).
> >> 
> >> 2. Hardware USO when hardware csum is unsupported / disabled
> >> 
> >> That sounds like a pathological device configuration case, but since it
> >> is possible today with some drivers to disable csum offload for one IP
> >> version and not the other, it seems safest to just handle that
> >> gracefully.
> >> 
> >> I don't know why one might want to do that. Perhaps as a workaround for
> >> some firmware bug while waiting for a fix?
> >
> > I doubt that this is actually used. But today it can be configured.
> >
> > Which is why I suggested making NETIF_F_GSO_UDP_L4 dependent on csum
> > offload (in netdev_fix_features). I doubt that that will break any
> > real user.
> 
> Sounds like a plan. If we're talking about simply disabling GSO_UDP_L4
> whenever either NETIF_F_IP_CSUM or NETIF_F_IPV6_CSUM is "off", then that
> is straightforward. And the NETIF_F_HW_CSUM dependency is clear.
> 
> I could even piggy back it on this series, at the risk of additional
> iterations.

A two patch series SGTM.

> >  
> >> In this scenario I think we also need to fall back to software USO and
> >> checksum.
> >> 
> >> Code-wise that could look like below. WDYT?
> >
> > Since this only affects USO, can we fix this is in __udp_gso_segment.
> > Basically, not taking the NETIF_F_GSO_ROBUST path.
> >
> > skb_segment is so complicated already. Whatever we can do to avoid
> > adding to that.
> 
> skb_segment is a complex beast. No disagreement there.
> 
> Keeping the changes down seems doable. We can drive skb_segment to
> compute the checksum, when we know that's needed (because IPv6 extension
> headers are present -> ip_summed is CHECKSUM_NONE) by masking off csum
> flags. Thanks for the suggestion.

Perfect.

The effort to add a selftest already proved its worth btw :)

