Return-Path: <netdev+bounces-138056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1639ABB59
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618681C20F4A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F8381BA;
	Wed, 23 Oct 2024 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+kepexT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65049620;
	Wed, 23 Oct 2024 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729649577; cv=none; b=m7Pbe7ezkjW8O+Eq7jLbNEaX3CxgcZ39g3t+kqs4mg9kIoG92SddHsJoCD+VvCfjIzzSvGN9RQ0nsqHVB2Hpud80jPXLcUd1MwksxO5WIfscUN3fOXvIwUibEwm7EKLBkqjn2GzZ//zjvVmTg2fE4fO0lhSJETrpfHMC64J5HXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729649577; c=relaxed/simple;
	bh=5B9SJRSxpgH+a2QQDn/7m98ugDjbIUWnL6gLprauvRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dce+5z5W0JIPJcyJiAse6+x2XQFn49jYIGgo6FwRPn8RDcZVPd9XYT5d5kSclltWT8E1CNCgsEmpnEHMwPfupDDuj8k+ZqAiQeEBO3KAJxTkjAS/VrRJHGATXSnXTJGZpDCFUZ0Fl13WjIregZDHD/5qs+GJDayZSDm/QcHsuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+kepexT; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso4484592a12.0;
        Tue, 22 Oct 2024 19:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729649575; x=1730254375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5B9SJRSxpgH+a2QQDn/7m98ugDjbIUWnL6gLprauvRk=;
        b=Y+kepexTL6QJx5ACMu98zYJXd5xH4Epw02GTaIGCTM8NI0Z7eLhhx8izqVziODeZkk
         tQAeoCUHP7c4D3aL/vvwiQtO1B8ouBIj8tb41ds91I4dFUM+yZ46fayRXGpdmlA8/z4X
         sF8DT3b2oQ0/jLt7AlkhhK8XLf69QGtsBPlyKQFUrVB8qcGVXeqRleU2JgZWHNTmUn8+
         UX1S49M6Y/1hJbvxSvlQ636m9dTXboUUsSERN+Kdc7E/c9EAy3EpEMDT4RNliNNCt+sq
         HAEJdha2Tt64d6qbyhP0joljKJ/rwXZ5ro6/vNq9iy8BIwyqk4GXQrcQoLSc4giM+4EA
         o72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729649575; x=1730254375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B9SJRSxpgH+a2QQDn/7m98ugDjbIUWnL6gLprauvRk=;
        b=jQPqFqJ0EEozQV0u0ME0zIyavJzPkObvgOLsJi5GMAubZpMysy+En6zAKlMMlrAgrc
         0m3J0eNzP2UjhYP2JMDa8wfFTXhgcfi1UOspIKHrKoug1ct/YReWFurXV/lPdbVxd97o
         AOjFrtx7BHQx5Ocj10NurxRj9lOvG+trXqTfzLN3hnTRdLOCQHhQusj1c721qqoQhp/s
         jHD11TQznYkNlqsCI02IHVM84UwZVaU12qI/uI7dgvy+pFnVad1035kXYY7OyKDTLVCm
         kRnJs6sQXBowCn/Hq0f6baZLJKdBEJCmbAfnTC7nyXBVS7uTokZMG6W5urmksBr8upAf
         tq7A==
X-Forwarded-Encrypted: i=1; AJvYcCVIVudMNoa0RG+ylUd/SIl5LZvs+tP13myULsI0lUdcH89ftyC5zY4eUl8W6keha06e7pdQSNKGTVXejjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/rQn6CZ2/9agKZ8VrtiyedUzP+YDzOWiWz+AFnd7ypv/kjdN
	tUOBynxd3gW+Samed+xbMit4+hPkckR7YkjUZaWDyX0QVqLbnVhS
X-Google-Smtp-Source: AGHT+IFGngh30tPnUsIitqRKW/TXZNiqX2UdKWf1av7Jf6M3yMXoiDLU5ZvkR2C/4+jJbiFyVtgfBw==
X-Received: by 2002:a05:6a20:e68c:b0:1d5:1729:35ec with SMTP id adf61e73a8af0-1d978aeac65mr1157129637.7.1729649574879;
        Tue, 22 Oct 2024 19:12:54 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76dfedbbfsm154240a91.56.2024.10.22.19.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 19:12:54 -0700 (PDT)
Date: Tue, 22 Oct 2024 19:12:46 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next 1/2] ptp: add control over HW timestamp latch
 point
Message-ID: <ZxhbnvaxmV0njtMu@hoboy.vegasvil.org>
References: <20241021141955.1466979-1-arkadiusz.kubalewski@intel.com>
 <20241021141955.1466979-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021141955.1466979-2-arkadiusz.kubalewski@intel.com>

On Mon, Oct 21, 2024 at 04:19:54PM +0200, Arkadiusz Kubalewski wrote:
> Currently HW support of PTP/timesync solutions in network PHY chips can be
> implemented with two different approaches, the timestamp maybe latched
> either at the beginning or after the Start of Frame Delimiter (SFD) [1].

Why did 802.3-2012 change the definition of the time stamp position?

Thanks,
Richard

