Return-Path: <netdev+bounces-155660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD267A034AB
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2A41617F1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D137EEB3;
	Tue,  7 Jan 2025 01:50:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF42133CA
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736214656; cv=none; b=fqgDoYW01n76NcnsOfWOsTJGI1XvAzVwXD4gVF2U6hGoWR8ECSrG6Q22e8Kies+oge8fS1JcPxmf8iHnk+qS++bWCW3zBUMpppdafEs9suB0LlbqGBep29UiAIlI39nxPwvIgKtPHyiSZFoUX41JGb8UwAglLn63Qijct387zt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736214656; c=relaxed/simple;
	bh=0JfBZ1BySczPCng08q/bQnqWBHSh6KGyaa1GAk07ODY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=sjB2oEtMlivmOXzDwTklnu0rzCv/HiG7UZoEcpavw2NfgBWKJgDPOWps9Y5wIXzsdgDtgdM2YnziIyRJxW5/lhhzG2aZLkfNYF4pnk/DQbM7NV6pJlB+zlO62cnFEJTAVfPccEIlFO0rbxtAP136Yxv5Z9SSVaV9pc2OROR2D38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas10t1736214643t645t04692
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.118.30.165])
X-QQ-SSF:0001000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12338266296209727114
To: "'Richard Cochran'" <richardcochran@gmail.com>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	<vadim.fedorenko@linux.dev>,
	<mengyuanlou@net-swift.com>
References: <20250106084506.2042912-1-jiawenwu@trustnetic.com> <20250106084506.2042912-4-jiawenwu@trustnetic.com> <Z3vzwiMzYDvmKisj@hoboy.vegasvil.org>
In-Reply-To: <Z3vzwiMzYDvmKisj@hoboy.vegasvil.org>
Subject: RE: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work of ptp_clock_info
Date: Tue, 7 Jan 2025 09:50:42 +0800
Message-ID: <034e01db60a6$8f984400$aec8cc00$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQFgxPKZN8TRQHApGKDHehP8aTZMFAHs3nX/AX2EEwWz5G+Q8A==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nd/Exl7W9DK5sFJB+nsAv1tBU5zzqfzfjkDOt01fh+KTEB7weQqgR1uF
	OTWSby2UieW6XL0Y5ODWT9HuEYk1Vs/nj396mEVkeCt1GIv5IL/uJpgxrHEkRbDUsM8dQzk
	KI4vlfflVcie/gUBIxM96dfCVI/F3aXuzrz2SmSekASV+wtK/K7xuWeucnMa9kYUcJ3DlNK
	2dacrKZP4UJsl0E05WUdJ5KBYCzj9Mz2t2Q1abP8bKDghbZL0kVorjC0UeSXMMYTsZJl/vC
	rUK6xUba92f6SL7KUw8p5fyWGT48UBUPY1lwFAIBwucoT0o2Jz0/jvWOQqNX54BDkmePBxK
	xD4/TxUvjnvelfrpDdu9kaaDI1naIcwoet/yf80UdnHsSVuPBLSvi55Kk191q+O44295219
	UlrDAF+ltkocP7+DpB+4G3K3JXsJRDHigRu3rtMbCZEl6QcRxD/7CerKTFk7elpNnKXHJx/
	GwVNxUHSA4QZ0CZcR67UPdcDE6vXsHTOD43fea3cul4+4xmDG4N9Pe5HCLPX8COhO0rZPmo
	s4l8vicsyd6rnt15NvhU2dXU1zhvUfE0tkQ9c8JYxKwQDFc5RCEI6mKWKiCEYT3T2ZUiMfe
	UWbALv4P+R2YW3/8L+7Q4cjGJrN8uczhemz8/Qe+0g6wfWksjKDsK84eMyO4inJcgV88vOq
	dVWU5nHoGU2pRtmopaE1xSBXByZUnIozLHzefwFCIy2k6QQHcsXwt513QsrisY7EgtxqorY
	Aq0V3cnqCk/qRRNz5cPfhsn0qNrqUK6WUOI5kxSC3CBnUF07Ep7UVzmtKBe0z5BVvhZkoVC
	A/bp+ryPEydGccL33KYVpcKYoPb+jTpSTolfgo0xr90/HjzjGOR8bIYVx+e6BNJuNBzGD8E
	ACj49ra5bg1x+N/sZdf8wVD1J5l7pVsteRpZlfvfKdsRIPS1HGekCzkRGzVXQhxF2kwHBBU
	Ucl4X8MOO1BiGlY8JVIXrZ8+v+8w6qEa73R27+J79ADZtNRCHtPEywNTJJWcKAvoFyUWQ0I
	zekSib1ZsWOs2HHT5CMdpB6oP7nQzz7lY804l5FmHGfUpb3JYvR/qpCzYpP9g=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Mon, Jan 6, 2025 11:16 PM, Richard Cochran wrote:
> On Mon, Jan 06, 2025 at 04:45:05PM +0800, Jiawen Wu wrote:
> 
> > +static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
> > +				 struct ptp_clock_request *rq, int on)
> > +{
> > +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> > +
> > +	/**
> > +	 * When PPS is enabled, unmask the interrupt for the ClockOut
> > +	 * feature, so that the interrupt handler can send the PPS
> > +	 * event when the clock SDP triggers. Clear mask when PPS is
> > +	 * disabled
> > +	 */
> > +	if (rq->type != PTP_CLK_REQ_PPS || !wx->ptp_setup_sdp)
> > +		return -EOPNOTSUPP;
> 
> NAK.
> 
> The logic that you added in patch #4 is a periodic output signal, so
> your driver will support PTP_CLK_REQ_PEROUT and not PTP_CLK_REQ_PPS.
> 
> Please change the driver to use that instead.

Oh sorry, I messed up the patches. These belong to patch 4/4.


