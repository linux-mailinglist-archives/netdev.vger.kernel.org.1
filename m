Return-Path: <netdev+bounces-225116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E976EB8E9A4
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 01:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B083A4D41
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 23:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06142A1BB;
	Sun, 21 Sep 2025 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdS840Js"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC32A55
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758498318; cv=none; b=nXDgOLM+WpqNQxF9HgocZFG41bvV8s50KMgdAQcSOZw6yEALfeDsk1N5D25pev+OSz1xZtBoj5HjOb1ijD+kZrxhpMv4gfXL2MPo3vtSKvvQFUrl8ImhWJ5ZA2Slf193Nsn9zMbOZ7GUHfe7pugwi/u5CVnrPDm4VBWFiu9YXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758498318; c=relaxed/simple;
	bh=veOV38c1Fti5YXPCBnjKL7+ahalmUM9pgSSZU2ObUnA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UKARKIsvz7I+MyfreB15OLThREO+4QwnWRzHLiyCVJzE0PLrzL/dQZ/S9bvuTnZ2DeWEacVrIvpQRdqpUocdCQ4hDyDJzpn1ynWc2hQ/NKauYPU5itO0eKutrg4ZZPXbi2jymQtxHtCfNB5Qw/xAud0Lgp+r4c9kNNMsrFkCUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdS840Js; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5515eaefceso2621703a12.2
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 16:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758498314; x=1759103114; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/FWUcSNNG/DoHNZVx8S+VseXsBG3I+a2ZNUiUVZ/TR8=;
        b=ZdS840JsO+LK/vsSKwm/57CJsl8l9WQapNNWVf6kba5/BAHOOAgwKu3Mc/QcVu6HG0
         7nA+I0ZA3cpNbsYkL0jpjT4ZPo/UO8zyHG+uQXDUogfCPcaXrZF95yoMhwJEfFWBki+n
         fQAlMMRiXfwDj3WEPBL6rUhVbwkmDlb5psS2PKcIFk16kXQPZQS7fo2d/K9ifqWf3/xm
         tnLXJrbgMVMbpxhrllxMmmaipFGr9x5+zy7xPoliyT77taSf/QCQX1v2/i+Fllu26INy
         JceifhUL08jfxPS167VKbERoqs1NSkK5c73rhSi95bYx2vsdSdYfY3UWHqE5fV8N6sgJ
         q9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758498314; x=1759103114;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FWUcSNNG/DoHNZVx8S+VseXsBG3I+a2ZNUiUVZ/TR8=;
        b=UelK8cRnRZhu96wnYPUJM5EhBKM/1u0VAyjoTT1js+e3EZEQcGvHYf9GYbQDyvkWoG
         oqh1yRqw4UxpCggQfW/bm+HzP41jCyf5GZmszeROf21/huuvm65BtZy/kR88I9/x65ze
         kyTtP2Xjxof8V2OsV66OEovw2gD6pzG/F39Lf0eXPFX/kgmA3CGf9d5xDV+30coN7FHk
         KnjwsTckil6TWcu/d58kQNL6cAsIEz/DagLvbeXDml9ozy8j58mc6itfLm7TysGEwxRd
         bwEj3VIrnjdTkR4uqGJoco8h3M68r5I3MH7/OYUIHAHC/Dm4yuLBu0vaRi/ioGkEHKc7
         n0VA==
X-Gm-Message-State: AOJu0YxK7w6u2WjesA6e7pASUsPE5alt6OP0KtqzzkCL+zx6QuZFBYsp
	jwmScbcnTdSGq0GQBE5J7nA0Ajoqd15whpzW8eNPHlrSqudJsE8K2AYU
X-Gm-Gg: ASbGncsMVHCozFDb5wtArHfg95tDfEyqdEyhfEa5RplSZGogiO6gr+xYNicEF73dMZy
	GGQn4EH0boNXIkapYqU9L04p5XkmckB+hdIyBIW/532Jz0tE7xqi62cLPUa1xdoAzvVP8lBjicP
	j0tvaGbbzjWb1u+XJLk0eXtxTMoDWmONl1o7hMVcIjnnw7IAJ6sjfRG1ECZXLdPfxR0WVhLvDId
	Mz4XDH1weFfl39VzqvF7158AdGvGCJCtoiE5X3GyrI2FajVKdCEDSEWvMhexeLA3bdio3hjJfXQ
	7g5qZ4uaw9EZRBT9cNM8V2aouumhxNoi+BeR7P4PZnrH18tm+cTlYgh4on5fjhiJ5rMcWCDtH0L
	YfkSDvH3IoRtJs5x/ik8jp03cmWoXjlnCR6BuP5Dt+S/dRZF8Kk2WHRaw674cUBvBnZ6l8pnONK
	rRWg==
X-Google-Smtp-Source: AGHT+IEvuh0H5483GDe47VhNHbqXlTroxZmjW2kd+mLgoLRD7ctJwHSwcUilwkEYkSbbLJH9V7ZNEw==
X-Received: by 2002:a17:902:d511:b0:24c:ce43:e60b with SMTP id d9443c01a7336-269ba45c0a8mr167106135ad.18.1758498314210;
        Sun, 21 Sep 2025 16:45:14 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2698016c959sm115371395ad.48.2025.09.21.16.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 16:45:13 -0700 (PDT)
Message-ID: <27b6b801c4cfbef1d5da95dab6d0305512874c2b.camel@gmail.com>
Subject: Re: [PATCH net-next] eth: fbnic: Read module EEPROM
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Ido Schimmel <idosch@idosch.org>, Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	gustavoars@kernel.org, horms@kernel.org, jacob.e.keller@intel.com,
 kees@kernel.org, 	kernel-team@meta.com, lee@trager.us,
 linux@armlinux.org.uk, pabeni@redhat.com, 	sanman.p211993@gmail.com,
 suhui@nfschina.com, vadim.fedorenko@linux.dev
Date: Sun, 21 Sep 2025 16:45:12 -0700
In-Reply-To: <aM-t4IBZFFHE9f-V@shredder>
References: <20250919191624.1239810-1-mohsin.bashr@gmail.com>
	 <aM-t4IBZFFHE9f-V@shredder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-09-21 at 10:48 +0300, Ido Schimmel wrote:
> On Fri, Sep 19, 2025 at 12:16:24PM -0700, Mohsin Bashir wrote:
> > Add support to read module EEPROM for fbnic. Towards this, add required
> > support to issue a new command to the firmware and to receive the respo=
nse
> > to the corresponding command.
> >=20
> > Create a local copy of the data in the completion struct before writing=
 to
> > ethtool_module_eeprom to avoid writing to data in case it is freed. Giv=
en
> > that EEPROM pages are small, the overhead of additional copy is
> > negligible.
> >=20
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
>=20
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>=20
> See a few questions below
>=20
> > ---
> >  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  66 +++++++++
> >  drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 135 ++++++++++++++++++
> >  drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  22 +++
> >  3 files changed, 223 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/=
net/ethernet/meta/fbnic/fbnic_ethtool.c
> > index b4ff98ee2051..f6069cddffa5 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > @@ -1635,6 +1635,71 @@ static void fbnic_get_ts_stats(struct net_device=
 *netdev,
> >  	}
> >  }
> > =20
> > +static int
> > +fbnic_get_module_eeprom_by_page(struct net_device *netdev,
> > +				const struct ethtool_module_eeprom *page_data,
> > +				struct netlink_ext_ack *extack)
> > +{
> > +	struct fbnic_net *fbn =3D netdev_priv(netdev);
> > +	struct fbnic_fw_completion *fw_cmpl;
> > +	struct fbnic_dev *fbd =3D fbn->fbd;
> > +	int err;
> > +
> > +	if (page_data->i2c_address !=3D 0x50) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Invalid i2c address. Only 0x50 is supported");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (page_data->bank !=3D 0) {
>=20
> What is the reason for this check?
>=20
> I understand that it's very unlikely to have a transceiver with banked
> pages connected to this NIC (requires more than 8 lanes), but it's
> generally better to not restrict this ethtool operation unless you have
> a good reason to, especially when the firmware seems to support banked
> pages.
>=20

I believe the origin of this is that for now we don't have any parts
that are making use of that field. If I recall the test systems are
running with QSFP-28.

That said I do agree we would probably change this out. I believe in
the original code we had as set of checks to enforce limitations on the
size and offset like below. Perhaps we would be better off with those:


        /* Nothing to do if read size is 0 */
        if (size =3D=3D 0)
                return 0;

        /* Limit reads to current page only, truncate the size to fit
         * current page only
         */
        if (offset < 128 && (offset + size) > 128)
                size =3D 128 - offset;

        /* If page or bank are set we are in paged mode, only support
         * offsets greater than 128
         */
        if ((page || bank) && offset < 128)
                return -EINVAL;
        if (offset + size > 256)
                return -EINVAL;


> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Invalid bank. Only 0 is supported");
> > +		return -EINVAL;
> > +	}
> > +
> > +	fw_cmpl =3D __fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_QSFP_READ_RESP,
>=20
> QSFP is not the most accurate term, but I assume it's named that way to
> be consistent with the HW/FW data sheet.
>=20

Yeah, it is the way the FW identifies the I2C bus in question. It is
referred to as the "QSFP" bus.

> > +					page_data->length);
> > +	if (!fw_cmpl)
> > +		return -ENOMEM;
> > +
> > +	/* Initialize completion and queue it for FW to process */
> > +	fw_cmpl->u.qsfp.length =3D page_data->length;
> > +	fw_cmpl->u.qsfp.offset =3D page_data->offset;
> > +	fw_cmpl->u.qsfp.page =3D page_data->page;
> > +	fw_cmpl->u.qsfp.bank =3D page_data->bank;
> > +
> > +	err =3D fbnic_fw_xmit_qsfp_read_msg(fbd, fw_cmpl, page_data->page,
> > +					  page_data->bank, page_data->offset,
> > +					  page_data->length);
> > +	if (err) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Failed to transmit EEPROM read request");
> > +		goto exit_free;
> > +	}
> > +
> > +	if (!wait_for_completion_timeout(&fw_cmpl->done, 2 * HZ)) {
> > +		err =3D -ETIMEDOUT;
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Timed out waiting for firmware response");
> > +		goto exit_cleanup;
> > +	}
> > +
> > +	if (fw_cmpl->result) {
> > +		err =3D fw_cmpl->result;
> > +		NL_SET_ERR_MSG_MOD(extack, "Failed to read EEPROM");
> > +		goto exit_cleanup;
> > +	}
> > +
> > +	memcpy(page_data->data, fw_cmpl->u.qsfp.data, page_data->length);
> > +
> > +exit_cleanup:
> > +	fbnic_mbx_clear_cmpl(fbd, fw_cmpl);
> > +exit_free:
> > +	fbnic_fw_put_cmpl(fw_cmpl);
> > +
> > +	return err ? : page_data->length;
> > +}
>=20
> [...]
>=20
> > +static int fbnic_fw_parse_qsfp_read_resp(void *opaque,
> > +					 struct fbnic_tlv_msg **results)
> > +{
> > +	struct fbnic_fw_completion *cmpl_data;
> > +	struct fbnic_dev *fbd =3D opaque;
> > +	struct fbnic_tlv_msg *data_hdr;
> > +	u32 length, offset, page, bank;
> > +	u8 *data;
> > +	s32 err;
> > +
> > +	/* Verify we have a completion pointer to provide with data */
> > +	cmpl_data =3D fbnic_fw_get_cmpl_by_type(fbd,
> > +					      FBNIC_TLV_MSG_ID_QSFP_READ_RESP);
> > +	if (!cmpl_data)
> > +		return -ENOSPC;
> > +
> > +	bank =3D fta_get_uint(results, FBNIC_FW_QSFP_BANK);
> > +	if (bank !=3D cmpl_data->u.qsfp.bank) {
> > +		dev_warn(fbd->dev, "bank not equal to bank requested: %d vs %d\n",
> > +			 bank, cmpl_data->u.qsfp.bank);
> > +		err =3D -EINVAL;
> > +		goto msg_err;
> > +	}
> > +
> > +	page =3D fta_get_uint(results, FBNIC_FW_QSFP_PAGE);
> > +	if (page !=3D cmpl_data->u.qsfp.page) {
>=20
> Out of curiosity, can this happen if user space tries to access a page
> that is not supported by the transceiver? I believe most implementations
> do not return an error in this case.

I believe this is meant to handle a possible race or out-of-order
condition on the FW mailbox in which we time-out one request, and then
immediately issue another. Essentially if we end up getting a
completion for a similar message, but it is for a different page/bank
or offset then we return an error instead of reporting it on the
completion.

