Return-Path: <netdev+bounces-116899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0415094C03C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7A9283117
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDAD18A6A0;
	Thu,  8 Aug 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCEjp7Ww"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317E4A33
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128663; cv=none; b=b7T9ORJrldufwW5hg4lF6EMaWW586EZN0cqgoKQOkLFuZUdataH2geO4yl+eARs+9leo6i7KT2RbV++gm+M8g1s/dJ+G2FckrOEcnlzElSJoqWUZKfVq1juMI1S8TArqn16GPz5LgZNu46/oxDemWccx8i8ICdBbZb7hyVqoNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128663; c=relaxed/simple;
	bh=+T6Cb0bb1GkEKLHGjPRaTyqUT0RxWzILVEsFXCEfX+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbqVV9ybvUyOQXa+yTTzwdae+fqUscBDyp1szrc5L2YIyPGX8KpzCI73k9t3cj0x2CLurIYQheoQccOxAPyL903nh19beUuH3aYKcs+PA0wQhCH1PN2dFwVHYoKuzvqPfYzsnA1ttDj8XbG7sdqR10SRMVkn5Au6z7PXcNaXANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCEjp7Ww; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723128660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwe03wU+6fEozd2HZdIZ+6GCEx1pYE4TjOsp+H7Gumw=;
	b=OCEjp7WwsfXjg/obF7xgkgN7Df957rtuaksmtb6syNappuxrwFKEqJfbfYboGIR3WDUrJY
	rjBs6iNZxGHzXP4l/otS1i6Qlq+2cWgRWhU8b6N/dOKqqYN4tmssEfOJx9Ln8oOM2A0TqT
	VWrVrdEni/viF786t8PXApBz1VFYbOw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-Q2kM1dg_MHWDO1_XQG-1xQ-1; Thu,
 08 Aug 2024 10:50:58 -0400
X-MC-Unique: Q2kM1dg_MHWDO1_XQG-1xQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E72F0195423F;
	Thu,  8 Aug 2024 14:50:55 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BC36300018D;
	Thu,  8 Aug 2024 14:50:55 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C19F2A809E4; Thu,  8 Aug 2024 16:50:52 +0200 (CEST)
Date: Thu, 8 Aug 2024 16:50:52 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: "Hall, Christopher S" <christopher.s.hall@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Zage, David" <david.zage@intel.com>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"rodrigo.cadore@l-acoustics.com" <rodrigo.cadore@l-acoustics.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/5] igc: Ensure the PTM
 cycle is reliably triggered
Message-ID: <ZrTbTNOOJq6NgX8U@calimero.vinschen.de>
Mail-Followup-To: "Hall, Christopher S" <christopher.s.hall@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Zage, David" <david.zage@intel.com>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"rodrigo.cadore@l-acoustics.com" <rodrigo.cadore@l-acoustics.com>
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
 <20240807003032.10300-2-christopher.s.hall@intel.com>
 <ZrOdthE36RQy78fx@calimero.vinschen.de>
 <PH7PR11MB697875DD586111AEF3F4B5DAC2B82@PH7PR11MB6978.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR11MB697875DD586111AEF3F4B5DAC2B82@PH7PR11MB6978.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Christopher,

On Aug  7 20:27, Hall, Christopher S wrote:
> Hi Corrina,

s/rrin/rinn/ ;)

> > > PHC2SYS exits with:
> > >
> > > "ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM
> > transaction
> > >   fails
> > 
> > It would be great to add the problems encountered with kdump to the
> > commit message as well, as discussed with Vinicius, wouldn't it?
> > 
> > If you need a description, I can provide one.
> 
> Does this patch fix the issue you observed?

Yes, it does.  

> If it does, I am happy to
> include your description of the problem it solves.

Is the following ok?

  This patch also fixes a hang in igc_probe() when loading the igc
  driver in the kdump kernel on systems supporting PTM.

  The igc driver running in the base kernel enables PTM trigger in
  igc_probe().  Therefore the driver is always in PTM trigger mode,
  except in brief periods when manually triggering a PTM cycle.

  When a crash occurs, the NIC is reset while PTM trigger is enabled.
  Due to a hardware problem, the NIC is subsequently in a bad busmaster
  state and doesn't handle register reads/writes.  When running
  igc_probe() in the kdump kernel, the first register access to a NIC
  register hangs driver probing and ultimately breaks kdump.

  With this patch, igc has PTM trigger disabled most of the time,
  and the trigger is only enabled for very brief (10 - 100 us) periods
  when manually triggering a PTM cycle.  Chances that a crash occurs
  during a PTM trigger are not 0, but extremly reduced.

> A tested-by tag would be appreciated as well.

Reviewed-by: Corinna Vinschen <vinschen@redhat.com>
Tested-by: Corinna Vinschen <vinschen@redhat.com> (kdump hang only)


Thanks,
Corinna


