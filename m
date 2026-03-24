Return-Path: <netdev+bounces-271328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNpVMRUVw2lCoAQAu9opvQ
	(envelope-from <netdev+bounces-271328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:49:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19631D74C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F18E30028F9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5823C6616;
	Tue, 24 Mar 2026 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goFNEleL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66EB2F3C26
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392570; cv=none; b=URXQRFzx883RtOGQB+xGmm4FNNYMqMiGDfTGZfdS4MKzf+jIfug7pfSXtwg7vEZHotHTmQunrpEm7k6gUwFzStNobax6zJjviNM59IJx+NGqo5N0DOl8o9g9WEoAHVQKsSkemuDCQCwB7Q5uKJxBFP25LLIbtpDD+1woYhp0oKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392570; c=relaxed/simple;
	bh=x66sLBkPM9N4hLXn1DtA+Tsks0CxriXlzYTWpFI/SYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhKYIUR4zN0/RY7uUDcJm5jrzgsXAiC5xTnWqlH2oEFoXHJ9C/aLgdzpSN5QYgiLUqmUWCAmo8CiTCMbFHI6XRb8EZAPUJ7PKnQ1fZjJxnEI0KDuJG26QTaMoshJ7xdoX4ydTuBw+5wDU8yHIDQR1fB/vFg0lHyXe89aZgpeXMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goFNEleL; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b6b0500e06so7119331eec.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392569; x=1774997369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNx1VzVQBg2bGT4I9Bs+XmhXlek+bgkFq6Ick2G8sfw=;
        b=goFNEleL/6OQLHn+J+oosYrN144Gvq3n9PxHX01b3AOoBSzMntlYyfDBUev1IPmigZ
         PJNtk4Puil6DsOG08u2pCFDFISC0hZRWi1B9SPmvozkwDXnq7KMGHUMsTG48keNg0TzD
         4ux7C9aM+cSk5nll4X0cKKMzWfJza7Ui2/qr02Y9axCLE+5UeHxyAg+zw5hr5ZMGy+s2
         Wr13RXhhNNJkgmTqx7vNdoQdlkz6i4BFXe5JyxWiA7mIuFsP21vN0NKAed52WPvzDxz3
         ClVP44k1pNh21rMwxWJ+CfYqfExhhx0OcvYywKMsYisw5flN0b4YHgQc14etyGiDFJ7r
         1NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392569; x=1774997369;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNx1VzVQBg2bGT4I9Bs+XmhXlek+bgkFq6Ick2G8sfw=;
        b=b2NWJuh5xfVscf6KpOhu1i1jZLdi58bf5nhOvkCq7w5gy1dvSq2liCAOyfISK+EeCU
         hiO1WOtJJ+HEbn1cMjj7w7dfWlZy5F3OjhgrxaIO6xMbSbzXtCWfvXmaBIXTfnNhZ4cH
         Z5B8lI7Uk3k61OW6LLHLv1umqcaOZtbQ2ZjQv7RV8VIAkM/Oew/62/QenCXyoPekiIh4
         TPnA+cQHdgDIbilQ9nc07rayrjbm7iRRYcaDjxqetsWZtZgU8LJfiJEGmaiWEh9rQ98X
         /HtXC0mEk3dvG/fKgOVYnZZiQCd7TOILNRp8bCgpFZjDc8Bn4atkGOpReNN/Q01DO65X
         zHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwVn5KYIM4u3y8LYUQdXZlvBt8HyR/pk5vY/msO6XGr87zRXAEXFidvcozP3uXpuF0dDoSI+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1MlFHqb9NmgYotYcf7/hN4ombogXIjUKoFRhEZHc5YWfZ+U/
	dwOfnXUPvSPIEWp0PVHxFfh/vs8n8hjLatZzaYPB3wHtE0xXGgClVhg=
X-Gm-Gg: ATEYQzx1sf9bvLYcFmIcwrlUw7cj0bURlzkaXLgD13PuKePiYeNNOX/Nqf1yOla+8sZ
	QmtQCtCHUhRRpwh3qT1yO+Q7FDDGyxhKZbZ8yvegELtL4DQUAYRYh22e/adgw8qRc0bwra9MfDG
	8JXm4Vhyyp680NR4uJUhOIRI+sI9H4P8lMVaHCQupVKxN+/FIcC3DdTFK25/tGuTN+CpIIUjyQe
	BvKsKv0BoQjVm7VVyZ8eZkyAF2bkn255W0aDVobzEiRKbssTlhECkYU7A4CayWiPUYV1ALuDCD+
	xgeyPeiuSno5gCKCDJHVlU+7On38H9kDL70O09qcBFxNfUaXBJ/kJ80YefpKrY5m96kF0+Zoxr8
	JWipIETaW/gOp7x8iEBFHmURBovb6+/LoYuM5AD2vgfSFjDAAgD0WS9/XqwlEv86DA5rZrHcbyF
	ihjv+TGFuAGUXI61QmsQbZjzpK3INICDTLCuOA8jbObYcUhggBet4vKVdY6fBRx1cemFYkVUnws
	7fyeVI1+MzpbmwXCEE/xmkqDVXr
X-Received: by 2002:a05:7301:6582:b0:2c1:2999:498e with SMTP id 5a478bee46e88-2c15d3a1176mr717588eec.18.1774392568523;
        Tue, 24 Mar 2026 15:49:28 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b1961a2sm16796758eec.12.2026.03.24.15.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:49:28 -0700 (PDT)
Date: Tue, 24 Mar 2026 15:49:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: Re: [PATCH net-next v3 03/13] net: introduce ndo_set_rx_mode_async
 and dev_rx_mode_work
Message-ID: <acMU93XN02PHmAGi@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-4-sdf@fomichev.me>
 <20260323162003.0d155055@kernel.org>
 <acLUMN1BYkIVyOk8@mini-arch>
 <20260324142114.216fcb01@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324142114.216fcb01@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271328-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[fomichev.me,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD19631D74C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/24, Jakub Kicinski wrote:
> On Tue, 24 Mar 2026 11:13:04 -0700 Stanislav Fomichev wrote:
> > > > +		netif_addr_lock_bh(dev);
> > > > +
> > > > +		err = __hw_addr_list_snapshot(&uc_snap, &dev->uc,
> > > > +					      dev->addr_len);
> > > > +		if (!err)
> > > > +			err = __hw_addr_list_snapshot(&uc_ref, &dev->uc,
> > > > +						      dev->addr_len);
> > > > +		if (!err)
> > > > +			err = __hw_addr_list_snapshot(&mc_snap, &dev->mc,
> > > > +						      dev->addr_len);
> > > > +		if (!err)
> > > > +			err = __hw_addr_list_snapshot(&mc_ref, &dev->mc,
> > > > +						      dev->addr_len);  
> > > 
> > > This doesn't get slow with a few thousands of addresses?  
> > 
> > I can add kunit benchmark and attach the output? Although not sure where
> > to go from that. The alternative to this is allocating an array of entries.
> > I started with that initially but __hw_addr_sync_dev wants to kfree the
> > individual entries and I decided not to have a separate helpers to
> > manage the snapshots.
> 
> Let's see what the benchmark says. Hopefully it's fast enough and 
> we don't have to worry. Is keeping these lists around between the
> invocations of the work tricky?

Yeah, that sounds doable, don't think it's too tricky, just extra
list_head on net_device + change the alloc/free to use it.
And then we keep this cache around until unregister? I will try to add it as
a separate patch to cache these entries to keep it simple for review..
 
> > > Can we give the work a reference on the netdev (at init time) and
> > > cancel + release it here instead of flushing / waiting?  
> > 
> > Not sure why cancel+release, maybe you're thinking about the unregister
> > path? This is rtnl_unlock -> netdev_run_todo -> __rtnl_unlock + some
> > extras.
> > 
> > And the flush is here to plumb the addresses to the real devices
> > before we return to the callers. Mostly because of the following
> > things we have in the tests:
> > 
> > # TEST: team cleanup mode lacp                                        [FAIL]
> > #       macvlan unicast address not found on a slave
> > 
> > Can you explain a bit more on the suggestion?
> 
> Oh, I thought it's here for unregister! Feels like it'd be cleaner to
> add the flush in dev_*c_add() and friends? How hard would it be to
> identify the callers in atomic context?

Not sure we can do it in dev_xc_add because it runs under rtnl :-(
I currently do flush in netdev_run_todo because that's the place that
doesn't hold rtnl. Otherwise flush will get stuck because the work
handler grabs it...

