Return-Path: <netdev+bounces-108603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D840E9247B9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BD21C24FDF
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6E41CCCBE;
	Tue,  2 Jul 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTSwVGSq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBE1CCCB5
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946694; cv=none; b=d/IGbnHOmul/FFi8GhIQKSHO3Ucnmr8CaBHQpQwbkFehAbZ4vvbMuk0VOoxKhs9gwL3s8zLMhmCbuv0dJt8rjDMyhKGm0MgZY0F9OM+9p6g0N+ogZ2WZbivJh7lnPD6LinHU0lor3lJQFYOr7m9Br+WOE10fpCH3Nupq1MQlY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946694; c=relaxed/simple;
	bh=4lGHtcpwZwS8LCTAnmMo55mSC0GqFCQQAX2udEuXA1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRnPDfkEk33H/NFT/qPagH47jNfpoGC2TLDNxGsahm7vK8tNWVzAt6NSHrAvOZ5SjEtFDKk3xjO72Dt/yJKfRYdzbGh7HTA51etLzL2qV1Y7XKJjFjwfe23WnM6Kh5yWiV9Addt3/sunIhCfT2H02w6lSgJc7IDH5noLBdSiKVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTSwVGSq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdbc20faeso6546349e87.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719946691; x=1720551491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4N+tEbb75+Q2pUQdMXhYugfNfAsFBzQnVIehrTNFoC0=;
        b=TTSwVGSq9o0kHd3eMsLcZ36wfE2EHXaxHBKzSvYg3f2H9ojtL1dr0FNRQU3NLnv3Zh
         Q/by6swuf8cfMc3mxZy2LhvKiLXNbgC/1+HRtszK5A/QfvbYomZxxpApmbGcsXmzv1OW
         A8QZ6TeRHNp71MxmSpiV+pTPvg9k2kmhctub4X/4PPm54nKjcXGDu/SobokOw7+F+OE2
         A3xERmWPz93UftCHxr+Izq7TF2y/evi/AqnflCUDri6GkTi575UhZS1fW4slZ4YeUBPf
         acq7tokyzQ5FXbFxwV4957UTgrVRLkIiA7RBJ6h7Bdozk59ORR0ZnDO4azEraivZ5IDq
         DY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946691; x=1720551491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4N+tEbb75+Q2pUQdMXhYugfNfAsFBzQnVIehrTNFoC0=;
        b=HoRwui6blT9mHJEpRsxQAQUtRXnxRXZAN6R5akP45JzDYOLPT8g27hLShMWA17GSr0
         /u+P5t3U49AbrxJPVMuuh6O6+i/0N00xs5k4JG4yu5eh89/7QpC3DiaNpG7cm6osFx8C
         2E8ho1yxMnJzPqrkQGpt+jOazLIVnZ5UgqhHGg3Ia5UkhLDbufG5KbUtDVD4ggbAaRNQ
         NtXhTMs7Il3ufbesTp0wa6Tr+mSlfe6zZmcJtV1+xIPVAyxBrFcyBxalfO4E/DRqMJjq
         3idZh6eL27Sa4rXQMDSEgqEIw/yMM5w3zB0Fn/NIcVqI/tXT5iMv0p4hq3nrfr2xIQXV
         1edg==
X-Gm-Message-State: AOJu0YweyTCr2DKICJ4twwJTbaIKn7cLXI7rCSkKLYrR9BtoPplzRvcO
	TlFd2f8zVcwGmRJFEnAlXSDpGQz5sspPS8k20DW6XJKammtKx/ioOJLrOmiVxSdWjKnD5JGjgmT
	zjY7GZpFmhmrlx+FwyUrnDRwVGoM=
X-Google-Smtp-Source: AGHT+IHxdwki1frrg4wpF5r9J1b83g9BL+ylle+kc9D53SNTzjFVgF2qJmY2acGzEMrFnb6hh8uIUcUjzh1oWsT1h4E=
X-Received: by 2002:a05:6512:ea2:b0:52e:76e8:e18e with SMTP id
 2adb3069b0e04-52e82648fe0mr6789595e87.7.1719946690336; Tue, 02 Jul 2024
 11:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
 <171993242260.3697648.17293962511485193331.stgit@ahduyck-xeon-server.home.arpa>
 <ZoQ3LlZZ47AJ5fnL@shell.armlinux.org.uk>
In-Reply-To: <ZoQ3LlZZ47AJ5fnL@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 2 Jul 2024 11:57:33 -0700
Message-ID: <CAKgT0UcPExnW2jcZ9pAs0D65gXTU89jPEoCpsGVVT=FAW616Vg@mail.gmail.com>
Subject: Re: [net-next PATCH v3 11/15] eth: fbnic: Add link detection
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 10:21=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Thanks for the patch - this is a review mainly from the phylink
> perspective.
>
> On Tue, Jul 02, 2024 at 08:00:22AM -0700, Alexander Duyck wrote:
> > +static irqreturn_t fbnic_pcs_msix_intr(int __always_unused irq, void *=
data)
> > +{
> > +     struct fbnic_dev *fbd =3D data;
> > +     struct fbnic_net *fbn;
> > +     bool link_up;
> > +
> > +     if (!fbd->mac->pcs_get_link_event(fbd)) {
> > +             fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0),
> > +                        1u << FBNIC_PCS_MSIX_ENTRY);
> > +             return IRQ_HANDLED;
> > +     }
> > +
> > +     link_up =3D fbd->link_state =3D=3D FBNIC_LINK_UP;
> > +
> > +     fbd->link_state =3D FBNIC_LINK_EVENT;
> > +     fbn =3D netdev_priv(fbd->netdev);
> > +
> > +     phylink_pcs_change(&fbn->phylink_pcs, link_up);
>
> fbd->link_state seems to be set to FBNIC_LINK_UP when the
> mac_link_up(), more specifically fbnic_mac_link_up_asic() gets called.
> No, never report back to phylink what phylink asked the MAC/PCS to do!
>
> If you don't know what happened to the link here, then report that the
> link went down - in other words, always pass "false" to
> phylink_pcs_change() which ensures that phylink will never miss a
> link-down event (because it will assume that the link went down.)
>
> I think you could even do:
>
>         struct fbnic_dev *fbd =3D data;
>         struct fbnic_net *fbn;
>         int status;
>
>         status =3D fbd->mac->pcs_get_link_event(fbd);
>         if (status =3D=3D 0) {
>                 fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0),
>                            1u << FBNIC_PCS_MSIX_ENTRY);
>         } else {
>                 fbn =3D netdiev_priv(fbd->netdev);
>
>                 phylink_pcs_change(&fbn->phylink_pcs, status > 0);
>         }
>
>         return IRQ_HANDLED;
>

I will probably just default it to false for now to keep it simple.

> > +/**
> > + * fbnic_mac_enable - Configure the MAC to enable it to advertise link
> > + * @fbd: Pointer to device to initialize
> > + *
> > + * This function provides basic bringup for the CMAC and sets the link
> > + * state to FBNIC_LINK_EVENT which tells the link state check that the
> > + * current state is unknown and that interrupts must be enabled after =
the
> > + * check is completed.
> > + *
> > + * Return: non-zero on failure.
> > + **/
> > +int fbnic_mac_enable(struct fbnic_dev *fbd)
> > +{
> > +     struct fbnic_net *fbn =3D netdev_priv(fbd->netdev);
> > +     u32 vector =3D fbd->pcs_msix_vector;
> > +     int err;
> > +
> > +     /* Request the IRQ for MAC link vector.
> > +      * Map MAC cause to it, and unmask it
> > +      */
> > +     err =3D request_irq(vector, &fbnic_pcs_msix_intr, 0,
> > +                       fbd->netdev->name, fbd);
> > +     if (err)
> > +             return err;
> > +
> > +     fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX=
),
> > +                FBNIC_PCS_MSIX_ENTRY | FBNIC_INTR_MSIX_CTRL_ENABLE);
> > +
> > +     phylink_start(fbn->phylink);
> > +
> > +     fbnic_wr32(fbd, FBNIC_INTR_SET(0), 1u << FBNIC_PCS_MSIX_ENTRY);
>
> If this is enabling the interrupt, ideally that should be before
> phylink_start().

Actually the interrupt is enabled after the first time
fbnic_pcs_get_link_asic/pcs_get_state is called.

From what I can tell this is just adding an extra manual interrupt
trigger, though it isn't setting any cause bits so it is most likely
there just to trigger the interrupt to clear stale data. I suspect
this is some holdover code from version 1 that wasn't based on
phylink.

> > +void fbnic_mac_disable(struct fbnic_dev *fbd)
> > +{
> > +     struct fbnic_net *fbn =3D netdev_priv(fbd->netdev);
> > +
> > +     /* Nothing to do if link is already disabled */
> > +     if (fbd->link_state =3D=3D FBNIC_LINK_DISABLED)
> > +             return;
> > +
> > +     phylink_stop(fbn->phylink);
>
> Why is this conditional? If you've called phylink_start(), and the
> network interface is being taken down administratively, then
> phylink_stop() needs to be called no matter what. If the link was
> up at that point, phylink will call your mac_link_down() as part
> of that. Moreover, the networking layers guarantee that .ndo_stop
> won't be called unless .ndo_open has been successfully called.

It is a bit of vestigial code from when we were running before adding
phylink support. This shouldn't stop us from calling phylink_stop as
the current setter for FBNIC_LINK_DISABLED is pcs_disable which is
called at the end of the phylink_stop function. Odds are this probably
mirrors PCS_STATE_DOWN

> > +static int fbnic_pcs_get_link_event_asic(struct fbnic_dev *fbd)
> > +{
> > +     u32 pcs_intr_mask =3D rd32(fbd, FBNIC_SIG_PCS_INTR_STS);
> > +
> > +     if (pcs_intr_mask & FBNIC_SIG_PCS_INTR_LINK_DOWN)
> > +             return -1;
> > +
> > +     return (pcs_intr_mask & FBNIC_SIG_PCS_INTR_LINK_UP) ? 1 : 0;
> > +}
>
> I think an enum/#define of some symbolic names would be useful both
> here and in the interrupt handler so we have something descriptive
> instead of -1, 0, 1.

I can look at converting these to an enum.

> > +static bool fbnic_pcs_get_link_asic(struct fbnic_dev *fbd)
> > +{
> > +     int link_direction;
> > +     bool link;
> > +
> > +     /* If disabled do not update link_state nor change settings */
> > +     if (fbd->link_state =3D=3D FBNIC_LINK_DISABLED)
> > +             return false;
>
> If phylink_stop() has been called (one of the places you set
> link_state to FBNIC_LINK_DISABLED) then phylink will force the link
> down and will disregard state read from the .pcs_get_state() method.
>
> The other place is when fbnic_pcs_disable_asic() has been called,
> which I think is hooked into the .pcs_disable method. Well, if
> phylink has called the .pcs_disable method, then it is disconnecting
> from this PCS, and won't be calling .pcs_get_state anyway.
>
> So all in all, I think this check is unnecessary and should be removed.

Agreed

> > +
> > +     /* In an interrupt driven setup we can just skip the check if
> > +      * the link is up as the interrupt should toggle it to the EVENT
> > +      * state if the link has changed state at any time since the last
> > +      * check.
> > +      */
> > +     if (fbd->link_state =3D=3D FBNIC_LINK_UP)
> > +             return true;
>
> Again, don't feed back to phylink what phylink asked you to do!

So the general idea with this is to avoid the need to recheck the
registers if there hasn't been an interrupt event to indicate that the
link changed. If the link has been confirmed up, and there hasn't been
a link event the assumption is we are still up. The interrupt for up
would be masked so we shouldn't see any up events as long as we are
up. That is why we just store the fact that the link is up and report
true here to indicate the link is present.

> > +
> > +     link_direction =3D fbnic_pcs_get_link_event_asic(fbd);
> > +
> > +     /* Clear interrupt state due to recent changes. */
> > +     wr32(fbd, FBNIC_SIG_PCS_INTR_STS,
> > +          FBNIC_SIG_PCS_INTR_LINK_DOWN | FBNIC_SIG_PCS_INTR_LINK_UP);
> > +
> > +     /* If link bounced down clear the PCS_STS bit related to link */
> > +     if (link_direction < 0) {
> > +             wr32(fbd, FBNIC_SIG_PCS_OUT0, FBNIC_SIG_PCS_OUT0_LINK |
> > +                                      FBNIC_SIG_PCS_OUT0_BLOCK_LOCK |
> > +                                      FBNIC_SIG_PCS_OUT0_AMPS_LOCK);
> > +             wr32(fbd, FBNIC_SIG_PCS_OUT1, FBNIC_SIG_PCS_OUT1_FCFEC_LO=
CK);
> > +     }
>
> If the link "bounces" down, then phylink needs to know - but that
> would be covered if, when you receive an interrupt, you always
> call phylink_pcs_change(..., false). Still, phylink can deal with
> latched-low clear-on-read link statuses. I think you want to read
> the link status, and if it's indicating link-failed, then clear
> the latched link-failed state.
>
> > +
> > +     link =3D fbnic_mac_get_pcs_link_status(fbd);
> > +
> > +     if (link_direction)
> > +             wr32(fbd, FBNIC_SIG_PCS_INTR_MASK,
> > +                  link ?  ~FBNIC_SIG_PCS_INTR_LINK_DOWN :
> > +                          ~FBNIC_SIG_PCS_INTR_LINK_UP);
>
> Why do you need to change the interrupt mask? Can't you just leave
> both enabled and let the hardware tell you when something changes?

It is mostly just about screening out unwanted info. As I mentioned we
were already tracking if we were up or down previously. So we were
only concerned if the link transitioned to the other state.

> > +static int fbnic_pcs_enable_asic(struct fbnic_dev *fbd)
> > +{
> > +     /* Mask and clear the PCS interrupt, will be enabled by link hand=
ler */
> > +     wr32(fbd, FBNIC_SIG_PCS_INTR_MASK, ~0);
> > +     wr32(fbd, FBNIC_SIG_PCS_INTR_STS, ~0);
> > +
> > +     /* Pull in settings from FW */
> > +     fbnic_pcs_get_fw_settings(fbd);
> > +
> > +     /* Flush any stale link status info */
> > +     wr32(fbd, FBNIC_SIG_PCS_OUT0, FBNIC_SIG_PCS_OUT0_LINK |
> > +                              FBNIC_SIG_PCS_OUT0_BLOCK_LOCK |
> > +                              FBNIC_SIG_PCS_OUT0_AMPS_LOCK);
>
> If the link went down, it's better to allow phylink to see that.

This isn't link down, this is a state link up we are flushing.

> > +static void fbnic_mac_link_down_asic(struct fbnic_dev *fbd)
> > +{
> > +     u32 cmd_cfg, mac_ctrl;
> > +
> > +     if (fbd->link_state =3D=3D FBNIC_LINK_DOWN)
> > +             return;
>
> You shouldn't need this.
>
> > +static void fbnic_mac_link_up_asic(struct fbnic_dev *fbd)
> > +{
> > +     u32 cmd_cfg, mac_ctrl;
> > +
> > +     if (fbd->link_state =3D=3D FBNIC_LINK_UP)
> > +             return;
>
> You shouldn't need this.

I can strip those two checks. They are mostly carry-over from an
earlier version.

> > +/* Treat the FEC bits as a bitmask laid out as follows:
> > + * Bit 0: RS Enabled
> > + * Bit 1: BASER(Firecode) Enabled
> > + * Bit 2: Autoneg FEC
> > + */
> > +enum {
> > +     FBNIC_FEC_OFF           =3D 0,
> > +     FBNIC_FEC_RS            =3D 1,
> > +     FBNIC_FEC_BASER         =3D 2,
> > +     FBNIC_FEC_AUTO          =3D 4,
> > +};
> > +
> > +#define FBNIC_FEC_MODE_MASK  (FBNIC_FEC_AUTO - 1)
> > +
> > +/* Treat the link modes as a set of moldulation/lanes bitmask:
>
> Spelling: modulation
>

Will fix.

> > @@ -22,9 +23,19 @@ struct fbnic_net {
> >
> >       u16 num_napi;
> >
> > +     struct phylink *phylink;
> > +     struct phylink_config phylink_config;
> > +     struct phylink_pcs phylink_pcs;
> > +
> > +     u8 tx_pause;
> > +     u8 rx_pause;
>
> If you passed these flags into your .link_up method, then you don't need
> to store them.

I need to keep track of the tx_pause at a minimum as a part of the Rx
queue configuration as we use it to determine if we drop packets for
full queues or push back into the FIFO.

> > +     u8 fec;
> > +     u8 link_mode;
>
> I think "link_mode" can be entirely removed.

I was actually going to reach out to you guys about that. For this
patch set I think it may be needed as I have no way to sort out
50000baseCR2 (NRZ, 2 lanes) vs 50000baseCR (PAM4, 1 lane) in the
current phylink code for setting the mac link up. I was wondering if
you had any suggestions on how I might resolve that?

Basically I have a laundry list of things that I was planning to start
on in the follow on sets:

1. I still need to add CGMII support as technically we are using a
different interface mode to support 100Gbps. Seems like I can mostly
just do a find/insert based on the PHY_INTERFACE_MODE_XLGMII to add
that so it should be straight forward.

2. We have 2 PCS blocks we are working with to set up the CR2 modes. I
was wondering if I should just be writing my PCS code to be handling
the merged pair of IP or if I should look at changing the phylink code
to support more than one PCS device servicing a given connection?

3. The FEC config is integral to the PCS and MAC setup on my device. I
was wondering why FEC isn't included as a part of the phylink code?
Are there any plans to look at doing that? Otherwise what is the
recommended setup for handling that as it can be negotiated via
autoneg for our 25G and 50G-R2 links so I will need to work out how to
best go after that.

> > +static void
> > +fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs,
> > +                         struct phylink_link_state *state)
> > +{
> > +     struct fbnic_net *fbn =3D fbnic_pcs_to_net(pcs);
> > +     struct fbnic_dev *fbd =3D fbn->fbd;
> > +
> > +     /* For now we use hard-coded defaults and FW config to determine
> > +      * the current values. In future patches we will add support for
> > +      * reconfiguring these values and changing link settings.
> > +      */
> > +     switch (fbd->fw_cap.link_speed) {
> > +     case FBNIC_FW_LINK_SPEED_25R1:
> > +             state->speed =3D SPEED_25000;
> > +             break;
> > +     case FBNIC_FW_LINK_SPEED_50R2:
> > +             state->speed =3D SPEED_50000;
> > +             break;
> > +     case FBNIC_FW_LINK_SPEED_100R2:
> > +             state->speed =3D SPEED_100000;
> > +             break;
> > +     default:
> > +             state->speed =3D SPEED_UNKNOWN;
> > +             break;
> > +     }
> > +
> > +     state->pause |=3D MLO_PAUSE_RX;
> > +     state->duplex =3D DUPLEX_FULL;
> > +     state->interface =3D PHY_INTERFACE_MODE_XLGMII;
>
> Please don't set state->interface, and please read the documentation
> for this method:
>
>  * Read the current inband link state from the MAC PCS, reporting the
>  * current speed in @state->speed, duplex mode in @state->duplex, pause
>  * mode in @state->pause using the %MLO_PAUSE_RX and %MLO_PAUSE_TX bits,
>  * negotiation completion state in @state->an_complete, and link up state
>  * in @state->link. If possible, @state->lp_advertising should also be
>  * populated.
>
> Note that it doesn't say that state->interface should be set (it
> shouldn't.)

Okay, I will remove that.

> > +int fbnic_phylink_init(struct net_device *netdev)
> > +{
> > +     struct fbnic_net *fbn =3D netdev_priv(netdev);
> > +     struct phylink *phylink;
> > +
> > +     fbn->phylink_pcs.ops =3D &fbnic_phylink_pcs_ops;
>
> Please also set phylink_pcs.pcs_neg_mode =3D true (required for modern
> drivers), especially as you call the argument "neg_mode" in your
> pcs_config function.

Will do.

