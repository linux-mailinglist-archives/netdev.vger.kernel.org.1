Return-Path: <netdev+bounces-257096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IWNL1FkhGkK2wMAu9opvQ
	(envelope-from <netdev+bounces-257096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:35:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ADBF0DC3
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 568EB303B4E1
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377F834D4DC;
	Thu,  5 Feb 2026 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="qh8/qmdc"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764038F95F
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283615; cv=none; b=UgJFXPQIzUPENRgXdNr7XLvlNuXXV2nI0fC2rhGaAvsajKJUFoflbhhlrKFjt2nEj2z3hzugClqPz+jSGgt+XKNO55A48zvkfTDS8R9hFXD9H1obBwiQsrNqaIxwSOWP+UgobuEBaInN9+qTIe+1Y7rzqhyDBCyxqowLfp8UV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283615; c=relaxed/simple;
	bh=/eYFYPf6wj0pWOW7CdqbqGSxJVMEvVaEBuNwLCuQBWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZO/j9G5g0ph4Ng2k6/eSM4hCaA+SlX1sxWlPyBfjcAwRtpdYv/eKwhbz0miW7GICL+1enEJMJN5fhb8zWVZlVkYOa/sjvMzaIYoGoshEcyi7rLci1iZVmzZXAV7+3SH13G/49fq/Rr+5ryCGMiYfMfH80/LbFF4iOjMIjRoXVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=qh8/qmdc; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6159QoOb043991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 5 Feb 2026 18:26:51 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=Tcc6PX6QF1vULhCJJzQoWngAFn2ua3JyJScC85lNYGk=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1770283612; v=1;
        b=qh8/qmdci12zQVNAFrKxK7comDby3Q/lv/luuEmIT3bR/AJsjA8e7eudeD7tKKwG
         WHltoUNz21k/3DWxGR8NKIirMtCSh1ODG/nC3gR4Pd0c859kbWtTs50fGsjPzIHW
         QzC9Q4l8DyLaxpQDx7KCM4I0vE/e1JraKj1D9GJGMC1gzeVcWSkPk8omQsBcwEqj
         dhhinzJizti4ftuPwJFwbnzH14nIlnQbVAfCMW7nRfvWqBEL75QPaABZF8qxfKUl
         44fBJ4eE+VQgL45S9LrurATe243IaggxT5oB9WnAlTKC8g2K3zoYVZUKwL9pfsv/
         oL8pygF4NcXyzoqsSYM+KQ==
From: Kohei Enju <kohei@enjuk.jp>
To: vitaly.lifshits@intel.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, intel-wired-lan@lists.osuosl.org,
        kohei.enju@gmail.com, kohei@enjuk.jp, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v1 iwl-net] igc: fix null pointer dereference in
Date: Thu,  5 Feb 2026 09:26:50 +0000
Message-ID: <20260205092650.7779-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <caf4b292-5fd0-4ced-bfbb-1ea4b99dca24@intel.com>
References: <caf4b292-5fd0-4ced-bfbb-1ea4b99dca24@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,google.com,lists.osuosl.org,gmail.com,enjuk.jp,kernel.org,vger.kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257096-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,enjuk.jp:email,enjuk.jp:dkim,enjuk.jp:mid]
X-Rspamd-Queue-Id: 21ADBF0DC3
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 11:16:50 +0200, "Lifshits, Vitaly" wrote:

> On 2/5/2026 10:50 AM, Kohei Enju wrote:
> > On devices without NVM, hw->nvm.ops.validate is set to NULL, therefore
> > functions that perform EEPROM-related operations such as
> > igc_ethtool_set_eeprom() and igc_probe() check for NVM presence in
> > advance. However igc_eeprom_test() unconditionally calls
> > hw->nvm.ops.validate(), potentially causing a null pointer dereference.
> > 
> > NVM-less devices may not be common but possible, so add NULL check
> > before calling hw->nvm.ops.validate().
> > 
> > Fixes: f026d8ca2904 ("igc: add support to eeprom, registers and link self-tests")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> >   drivers/net/ethernet/intel/igc/igc_diag.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/igc/igc_diag.c b/drivers/net/ethernet/intel/igc/igc_diag.c
> > index a43d7244ee70..973d26a5a6c9 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_diag.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_diag.c
> > @@ -158,7 +158,7 @@ bool igc_eeprom_test(struct igc_adapter *adapter, u64 *data)
> >   
> >   	*data = 0;
> >   
> > -	if (hw->nvm.ops.validate(hw) != IGC_SUCCESS) {
> > +	if (hw->nvm.ops.validate && hw->nvm.ops.validate(hw) != IGC_SUCCESS) {
> >   		*data = 1;
> >   		return false;
> >   	}
> 
> 
> Hi Kohei,
> 
> Thank you for your patch.
> 
> Since there are no NVM-less devices I suggest removing the flash-less 
> code entirely from the init flow.

Oh, I see there're no NVM-less devices. Then removing sounds good to me.

Could you clarify what you mean by "init flow"? Do you mean removing
only the flash-less branch in igc_init_nvm_params_i225(), or removing
all flash-less related code including igc_get_flash_presence_i225() and
its callers?

After clarification, I'd love to work on it. Thank you for taking a
look!

