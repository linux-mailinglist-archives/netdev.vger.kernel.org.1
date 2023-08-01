Return-Path: <netdev+bounces-23093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF11C76AB49
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912562816EB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C385B1F199;
	Tue,  1 Aug 2023 08:45:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00CB1C33
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:45:18 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3374F1B6;
	Tue,  1 Aug 2023 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+iCOMUZEBRmp0SfXP3l/d75t5cDd7ZTASaBmWC/aA3g=; b=Hr21qsxB3uCtbyYtTq54zdvsSe
	LSi1orVTZmDgACnr7OMqBi+zYld5OJZ1RM1gHcmzXtsEHsV5SuYD3iFm3BSo5rp9yREoQayT68pFz
	fWMRqbZcyz5EXaHHfzjS0N3NLiF1Mvnnj0Ta8kGGy5YoOnT1iig3AvDdcVNgJVykHcY4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qQl00-002mRI-9L; Tue, 01 Aug 2023 10:45:00 +0200
Date: Tue, 1 Aug 2023 10:45:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Chris Lew <quic_clew@quicinc.com>, Alex Elder <elder@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/4] soc: qcom: aoss: Add debugfs interface for sending
 messages
Message-ID: <98179d9e-0c03-4659-9dcc-73a411bfa00e@lunn.ch>
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-3-quic_bjorande@quicinc.com>
 <21dfb855-8f44-4a4c-9dba-52eb5ae46b9b@lunn.ch>
 <20230731153938.GF1428172@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731153938.GF1428172@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 08:39:38AM -0700, Bjorn Andersson wrote:
> On Mon, Jul 31, 2023 at 10:21:31AM +0200, Andrew Lunn wrote:
> > On Sun, Jul 30, 2023 at 09:10:11PM -0700, Bjorn Andersson wrote:
> > > From: Chris Lew <clew@codeaurora.org>
> > > 
> > > In addition to the normal runtime commands, the Always On Processor
> > > (AOP) provides a number of debug commands which can be used during
> > > system debugging for things such as preventing power collapse or placing
> > > floor votes for certain resources. Some of these are documented in the
> > > Robotics RB5 "Debug AOP ADB" linked below.
> > > 
> > > Provide a debugfs interface for the developer/tester to send these
> > > commands to the AOP.
> > 
> > This sort of sending arbitrary binary blob commands is not liked,
> > since it allow user space closed source drivers. At minimum, please
> > provide a file per command, with the kernel marshalling parameters
> > into the binary format, and decoding any returned values.
> > 
> 
> Thanks for your input Andrew, that is a valid concern.
> 
> The interface is in debugfs and as such wouldn't be suitable for closed
> source drivers, as in the majority of our shipping software debugfs
> isn't enabled.

There only appears to be 3 commands, so it is now too much of a burden
to do it properly, and not have a binary blob API.

And most distros do have debugfs at least built and available, but
maybe not mounted.

      Andrew

