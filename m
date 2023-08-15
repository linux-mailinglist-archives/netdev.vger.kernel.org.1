Return-Path: <netdev+bounces-27576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A308577C703
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD671C20B55
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 05:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCB73D86;
	Tue, 15 Aug 2023 05:23:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293681864
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 05:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D00C433C8;
	Tue, 15 Aug 2023 05:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692076986;
	bh=+/FXUiff9U2dvHx0FZl3BeA6ZvQozpS5ddrmrxlXxpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OL4djTyHf23sj6ZTlXNUbaEbT+VYm2q9wYuPGm7YGWcOFw4p04wz9QlJvTrPGLIW4
	 ZgzHisb9v1HazEltqXLqnTULF90luD5b6JB73yBLEwiDiUhT+rHj3q9zvOxFNu25Kw
	 kf4gZ47+7FxxMJbx5LNphLubDjusRYaFnXgZI/L4OSaOQ9nar2wTuvAerQRVgb3l0w
	 RgStbCcD5NanKXWPU48LynF4QmRiTGjZQK+OcWCgcBkiMWXGDRfFD4tSP+47sYMnmR
	 msB+MJEXFTR6dpWzOLtBhWMB+LFAjHyq496Z6DNDj31IOEzDnKeiLwKaTuaB9iyJC9
	 QyYZELK91oXaw==
Date: Tue, 15 Aug 2023 08:23:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Alessio Igor Bogani <alessio.bogani@elettra.eu>,
	richardcochran@gmail.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 1/2] igb: Stop PTP related workqueues if aren't
 necessary
Message-ID: <20230815052301.GC22185@unreal>
References: <20230810175410.1964221-1-anthony.l.nguyen@intel.com>
 <20230810175410.1964221-2-anthony.l.nguyen@intel.com>
 <20230813090107.GE7707@unreal>
 <f8b9cd9e-651b-8488-5c4f-aacc03a3c9c8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b9cd9e-651b-8488-5c4f-aacc03a3c9c8@intel.com>

On Mon, Aug 14, 2023 at 03:16:05PM -0700, Tony Nguyen wrote:
> 
> 
> On 8/13/2023 2:01 AM, Leon Romanovsky wrote:
> > On Thu, Aug 10, 2023 at 10:54:09AM -0700, Tony Nguyen wrote:
> > > From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> > > 
> > > The workqueues ptp_tx_work and ptp_overflow_work are unconditionally allocated
> > > by igb_ptp_init(). Stop them if aren't necessary (ptp_clock_register() fails
> > > and CONFIG_PTP is disabled).
> > > 
> > > Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> > > Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > ---
> > >   drivers/net/ethernet/intel/igb/igb_ptp.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> > > index 405886ee5261..02276c922ac0 100644
> > > --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> > > +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> > > @@ -1406,7 +1406,13 @@ void igb_ptp_init(struct igb_adapter *adapter)
> > >   		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
> > >   			 adapter->netdev->name);
> > >   		adapter->ptp_flags |= IGB_PTP_ENABLED;
> > > +		return;
> > >   	}
> > > +
> > > +	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
> > > +		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
> > > +
> > > +	cancel_work_sync(&adapter->ptp_tx_work);
> > 
> > Is it possible to move work initialization to be after call to ptp_clock_register()?
> 
> I'm under the impression that everything should be ready to go before
> calling ptp_clock_register() so we shouldn't register until the workqueues
> are set up.

I honestly don't know.

Thanks

> 
> Thanks,
> Tony
> 
> > diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> > index 405886ee5261..56fd2b0fe70c 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> > @@ -1386,11 +1386,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
> >          }
> >          spin_lock_init(&adapter->tmreg_lock);
> > -       INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
> > -
> > -       if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
> > -               INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
> > -                                 igb_ptp_overflow_check);
> >          adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
> >          adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
> > @@ -1407,6 +1402,15 @@ void igb_ptp_init(struct igb_adapter *adapter)
> >                           adapter->netdev->name);
> >                  adapter->ptp_flags |= IGB_PTP_ENABLED;
> >          }
> > +
> > +       if (!adapter->ptp_clock)
> > +               return;
> > +
> > +       INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
> > +
> > +       if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
> > +               INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
> > +                                 igb_ptp_overflow_check);
> >   }
> >   /**
> > 
> > 
> > 
> > 
> > >   }
> > >   /**
> > > -- 
> > > 2.38.1
> > > 
> > > 

