Return-Path: <netdev+bounces-104425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD1290C793
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F7E2855B5
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655D71BD01A;
	Tue, 18 Jun 2024 09:04:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B481BC093
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701453; cv=none; b=Lcx/WhkDxTfJd9e3tZSlsryl9fXEDCBeFtDlrghheWzujsmxy7ZY0ek42XCrzrfEvHrGs8bGyKZjdQzqsmu/UmKuTosNZIgxMJPqVMntcMxCACARnxkDg7QjKjCaoeihMhHLqNO5YWDk7jTKBraQg6c3/OTUMnolkVMQxRdWEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701453; c=relaxed/simple;
	bh=XssdP2rHnSYW8IPYR4+kzwk8tklcuW6wleiSaF17u2A=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=dvsekZEWPcizoVrNvQsqaFFK0rqP/4+odBuSPUGNHJPl0l4gKyY0fG6oyeAHXXrISelI7u0Ci5rFSRitrT5U4UYhotZUBlLomO5t2Dv8ccA92G4uMzM4CPs34bUzS+fCT4WhsULJzoWC9E35nziCR06A+zwKpLGHqJtpIgSPGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas55t1718701351t880t24809
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.159.97.141])
X-QQ-SSF:00400000000000F0FVF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 13991601902812410278
To: "'Simon Horman'" <horms@kernel.org>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20240605020852.24144-1-jiawenwu@trustnetic.com> <20240605020852.24144-3-jiawenwu@trustnetic.com> <20240606204959.GP791188@kernel.org>
In-Reply-To: <20240606204959.GP791188@kernel.org>
Subject: RE: [PATCH net-next v2 2/3] net: txgbe: support Flow Director perfect filters
Date: Tue, 18 Jun 2024 17:02:30 +0800
Message-ID: <00d501dac15e$4034f530$c09edf90$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQH0eqJcG+ogIoRI8v7BTXwUMbAV0QIsFs7TAUXizRixfjZpgA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

> > +	/* only program filters to hardware if the net device is running, as
> > +	 * we store the filters in the Rx buffer which is not allocated when
> > +	 * the device is down
> > +	 */
> > +	if (netif_running(wx->netdev)) {
> > +		err = txgbe_fdir_write_perfect_filter(wx, &input->filter,
> > +						      input->sw_idx, queue);
> > +		if (err)
> > +			goto err_unlock;
> > +	}
> > +
> > +	txgbe_update_ethtool_fdir_entry(txgbe, input, input->sw_idx);
> > +
> > +	spin_unlock(&txgbe->fdir_perfect_lock);
> > +
> > +	return err;
> 
> Hi Jiawen Wu,
> 
> Smatch flags that err may be used uninitialised here.
> I'm unsure if that can occur in practice, but perhaps it
> would be nicer to simply return 0 here.
> 
> > +err_unlock:
> > +	spin_unlock(&txgbe->fdir_perfect_lock);
> > +err_out:
> > +	kfree(input);
> > +	return -EINVAL;
> 
> And conversely, perhaps it would be nicer to return err here - ensuring is
> it always set.  F.e. this would propagate the error code returned by
> txgbe_fdir_write_perfect_filter().

I think it can be changed to initialize err = 0, and return err in these two places.



