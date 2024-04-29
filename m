Return-Path: <netdev+bounces-92168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64DD8B5B44
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 16:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BFF1C21209
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7017BB654;
	Mon, 29 Apr 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgzNXZlb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA53BDDD5
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401059; cv=none; b=ekRVgJfYfrxDmfSqEGMOIR3iL2zuXPMIK/L1vvy4stLcig2c4cfyEQfIZJCeXcieTrexeWuSqqm4MPw8HvPcGcMS5FidCzhK09iInByXtg/+yWUeGQeIVrw7szIc5EcMBnYhvkohXnL1TOJ3Sv8hqIXlL4abIG2cNdm5+LQN0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401059; c=relaxed/simple;
	bh=oYIzb5bXiT0btuHE7Rvi0W6A36FwygO503CUerNZiz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2vfioDhJ3NrrdVig1c0IZ38R9xLAPb1PHYLIWRAV/qQRET89VWeevo0Jr2096tHwFw1MFGQF7qcHlpt4ebp2Fklp5zRk9Rm+BZuLx/9vRfX+eK6v9CGq0foIspjPd+kDeK5okpOV2GHCDXtL4sz3Os1Iyn5DVL2GCzddMdQB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgzNXZlb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714401056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f9bY8Ll9oQ6IR9DHuROsI2DP39lzpeUexS6Phh7yYVE=;
	b=HgzNXZlbiFOyBPNl/mQVvcGH8WSOtV87hYfyl70z7SGaXQ2jVoOQgYkWoG3+MIFvsE3BV1
	acYKxPMrm0/wll/4nhEEZwnb9notMXN7qlLrovVwLctPx4S2LvniFoxG1htTnN6Cc/DyWY
	bIQh3sIkshGOLz1KtafEbVj/0CDrMgw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-FXxtTnwPOQu8tWB8pAIyzg-1; Mon, 29 Apr 2024 10:30:55 -0400
X-MC-Unique: FXxtTnwPOQu8tWB8pAIyzg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c65e666609so5034264a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 07:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714401053; x=1715005853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9bY8Ll9oQ6IR9DHuROsI2DP39lzpeUexS6Phh7yYVE=;
        b=NVsEQcPbadQODZ22mMUXatI230d/X4nzZczNMRgJt+rPpEHWZm53hDVz4ocbGGXvcj
         i7aoUooaWVF8zP5U+2Rg2SuVBCpo8saqRB5GVCIc2u9fkYmB330V/EdM3WJWpOHzvraH
         U2akw+zkdgd2ZlZb9i45jli1Rd8X7As/86FhJ57q/jcQ0tbu3EAd6rXtwfvOez+G7/l5
         8bwTiWbtjMkbpBIpq1+E44Uj90fQcR+nwGd9qWzNTjUs2RHJOvMFlEziHirUNxmYpmoS
         kqz4rFadKobJNImuq6aL7/cqCOVISyE0RmI7h5gFUwNTWNGzGzcDQsK/V38fLoUyLofe
         iXMA==
X-Forwarded-Encrypted: i=1; AJvYcCXFR//2oUx4hjsaxEhskNVNuIjfThgLizf0H4gu/tsPzHT5AisqUMxiwbo73PTXeZ5I0AE3MlQzpeXpNEwhSHXsmyG+wp2N
X-Gm-Message-State: AOJu0YylyIoJHBLYcKwj2HxuFabwJ+RJNW7laaorB4/Oy1Jlo1pbzaOq
	XCmXa31vMSYquYZ9upzv/m7443/u4U4+tC1qMjG0kwhk+xclhU+U5RA7Swn0a1YdDvgguDG9sPU
	MZc3FG6X+sJZvLJNIYHxJOd7eEFy45f9LpDxLMndoKDAXSua5xeO4Yg==
X-Received: by 2002:a17:90a:c302:b0:2ae:72a3:2ed4 with SMTP id g2-20020a17090ac30200b002ae72a32ed4mr10361918pjt.15.1714401053525;
        Mon, 29 Apr 2024 07:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa1iFwK9a8Zfq3hxj2/6l/xfm7hk0Jp3nCMo7lzvLfSTOnADr0QRRxDygYcLTwMtVltRkcOA==
X-Received: by 2002:a17:90a:c302:b0:2ae:72a3:2ed4 with SMTP id g2-20020a17090ac30200b002ae72a32ed4mr10361889pjt.15.1714401053101;
        Mon, 29 Apr 2024 07:30:53 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id f22-20020a17090ace1600b002a47e86fd5esm19351297pju.4.2024.04.29.07.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:30:52 -0700 (PDT)
Date: Mon, 29 Apr 2024 23:30:48 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com,
	syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <Zi-vGH1ROjiv1yJ2@zeus>
References: <20240427103558.161706-1-ryasuoka@redhat.com>
 <20240428134525.GW516117@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428134525.GW516117@kernel.org>

On Sun, Apr 28, 2024 at 02:45:25PM +0100, Simon Horman wrote:
> On Sat, Apr 27, 2024 at 07:35:54PM +0900, Ryosuke Yasuoka wrote:
> > syzbot reported the following uninit-value access issue [1]
> > 
> > nci_rx_work() parses received packet from ndev->rx_q. It should be
> > validated header size, payload size and total packet size before
> > processing the packet. If an invalid packet is detected, it should be
> > silently discarded.
> > 
> > Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> > Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534 [1]
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> 
> ...
> 
> > @@ -1516,30 +1526,36 @@ static void nci_rx_work(struct work_struct *work)
> >  		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
> >  				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
> >  
> > -		if (!nci_plen(skb->data)) {
> > -			kfree_skb(skb);
> > -			break;
> > -		}
> > +		if (!skb->len)
> > +			goto invalid_pkt_free;
> >  
> >  		/* Process frame */
> >  		switch (nci_mt(skb->data)) {
> >  		case NCI_MT_RSP_PKT:
> > +			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> > +				goto invalid_pkt_free;
> 
> Hi Yasuoka-san,
> 
> My reading is that this will jump to the label invalid_pkt_free,
> which is intended.
> 
> >  			nci_rsp_packet(ndev, skb);
> >  			break;
> 
> But this will exit the switch statement, which lands
> at the label invalid_pkt_free, where skb is kfreed.
> This doesn't seem to be intended.
> 
> >  
> >  		case NCI_MT_NTF_PKT:
> > +			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> > +				goto invalid_pkt_free;
> >  			nci_ntf_packet(ndev, skb);
> >  			break;
> >  
> >  		case NCI_MT_DATA_PKT:
> > +			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE))
> > +				goto invalid_pkt_free;
> >  			nci_rx_data_packet(ndev, skb);
> >  			break;
> >  
> >  		default:
> >  			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
> > -			kfree_skb(skb);
> > -			break;
> > +			goto invalid_pkt_free;
> >  		}
> 
> If so, then one solution may be to add the following here:
> 
> 		continue;
> 
> > +invalid_pkt_free:
> > +		kfree_skb(skb);
> > +		break;
> >  	}
> >  
> >  	/* check if a data exchange timeout has occurred */
> > -- 
> > 2.44.0
> > 
> > 
> 

Thank you for your comment, Simon.

Yes, if it handles packets correctly in nci_{rsp,ntf,rx_data}_packet(),
it should not reach invalid_pkt_free and it should continue to work in
the for statement. Sorry, it is my mistake and need to fix it.

BTW, in the current implementation, if the payload is zero, it will free
the skb and exit the for statement. I wonder it is intended. 

> > -		if (!nci_plen(skb->data)) {
> > -			kfree_skb(skb);
> > -			break;
> > -		}

When the packet is invalid, it should be discarded but it should not
exit the for statement by break. Instead, the skb should just free and
it should handle the subsequent packet by continue. If yes, then it 
may be like below,

	for (; (skb = skb_dequeue(&ndev->rx_q)); kcov_remote_stop()) {
		kcov_remote_start_common(skb_get_kcov_handle(skb));

		/* Send copy to sniffer */
		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);

		if (!skb->len)
			goto invalid_pkt_free;

		/* Process frame */
		switch (nci_mt(skb->data)) {
		case NCI_MT_RSP_PKT:
			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
				goto invalid_pkt_free;
			nci_rsp_packet(ndev, skb);
			continue;   <<<---

		case NCI_MT_NTF_PKT:
			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
				goto invalid_pkt_free;
			nci_ntf_packet(ndev, skb);
			continue;   <<<---

		case NCI_MT_DATA_PKT:
			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE))
				goto invalid_pkt_free;
			nci_rx_data_packet(ndev, skb);
			continue;   <<<---

		default:
			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
			goto invalid_pkt_free;
		}
invalid_pkt_free:
		kfree_skb(skb);
	}

Could I hear your opinion?


