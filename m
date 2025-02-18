Return-Path: <netdev+bounces-167537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3451A3AB66
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 23:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1F4189679E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6CE1B4F0F;
	Tue, 18 Feb 2025 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CqhSWlg3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FEC2862BD
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739916046; cv=none; b=MVPI5NwEkjWP+RZ7i7DXClGjnHnSu4zggbUshYw7lRmzK5ChtdOYVxA2rF4ZHGoK0ytL298d41EQoCRbk04yW/kh0eFRvQX30d33kGsFUiNQYBdDBQBR8GNMzkTTtgd6ND3JcrTQG0VH9FiyHAxQVfHR1nOZqr5Z8PX3zAXXpLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739916046; c=relaxed/simple;
	bh=k5BqYLudz8oSyV+x2HpFneJFKp/8woT9rD9eVhLOsi8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOrWMkbqnvFHqrrKbBPgc5+JnA8K0yjs/1nnbAPgxVyied4Bna1IZ7RMw3n5o3abwmtycHP/FmrFn0MigotnXbw41hoytQKc36dNnuxkpI99stkWSStglmtQ7UrbQKCw3MIGtR5e4suiDVUuUDwNb/VYmXSeHFAQC+GHzDNaFqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CqhSWlg3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471f257f763so20366451cf.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 14:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739916044; x=1740520844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NDWVoyJ1SeooEMJORrstyMdt33FZ55CnXUZgLN9GUJQ=;
        b=CqhSWlg3dBsZCIf2ZBIH4QNWt1e+98Iaqbjken1PPZwRr+8SKA9Zhpbafu1T77euOr
         iBsCFXqTh+MSES8eZpxZdhniChDyAx/TR6IfhV//rgnm+Mpb3cV0sipJoNZVWF1CgYDl
         7VaZ0IhlNMKPKHZkXRzXOpeJrWVfSKK9djaCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739916044; x=1740520844;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDWVoyJ1SeooEMJORrstyMdt33FZ55CnXUZgLN9GUJQ=;
        b=CMVmVf5rJOQeL0hcFgtg/r6KbBdverzbEbWjT9M9I+rVfIBW15UflJRwckiRqeglEL
         zOncisSeMSAEM4JrryJlyqEUp1aWcMSbK8oACaBelrdAo67UZnM4PjS1VqxxNvz+bbM+
         mW4Jpw7hAL6PgwMwXkBvORg3/5CCBQ7CsreL83cSuTdfkRpzN7NuembVxtysc5enDGNy
         xBS6bFw++tNT/6y4gw2NXjgWlq/1hWjw9iOjP1TYdS/BlsHMDh2WjzhqvziW0twMYzH8
         BPoLutJh2xot7Mp6wEVDW3EUxML/sgHvaU8UEPXHbC1xf5XLk+XHjyQmNdQA01yNYQ1B
         3qeg==
X-Forwarded-Encrypted: i=1; AJvYcCVS4RYONyOm8NE7KW6fNLnbKTMXqd7xoqYfvgjmPoPTuXs5joIImm/h34ACNigtOZGkzCHiBJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBYgOkKFjCwg0h60YPSvdG3O4eLXJz232OSE3F5bkCkmyc30E
	ZWKRDqQAZr9KTC5beRIxVPEjNQ02u3eqQqOuSQ4rr9E6bizfPNWqbSOGxze/eBE=
X-Gm-Gg: ASbGnctHEg4XqhLlhP9+DLDq1DzaIlclqan0h1AD9crJzSQqGKhenNq2Ui5nMJJeVqr
	5P7MARw1OF/bH2zrauy8d11AnAYyU2OSv9a9jhdHeZPdWu7AwhLewJTu0I4T4w6D2+O407y2Py/
	vXw1pJ0rAMJN6iRQE3kAJV4xsx+8UTPGd2i09JMbTFSZfEN2Z3K+uSarO51p0eeoieKNEpC6S87
	ocOI7ypiKbK0wwZyUQ7vJpLeo8JzXUi1XJftE5QyteOJnzz12nhATKkL9XiTB8R7Mcp5Xofm9u6
	rdbk13AhreGff2wG+kX0PKmI63GaBHkg7BBYuXf1gXTI/xN/HFc0mA==
X-Google-Smtp-Source: AGHT+IFF3jhc9h+lBjYvLv886LHEtmD9+ojqQqm9gIwO6LpvxiYXxuB+1ocnHpxdisTfrFAz6rqh6w==
X-Received: by 2002:a05:622a:8f02:b0:471:f730:20bf with SMTP id d75a77b69052e-471f73027c9mr65171161cf.12.1739916044112;
        Tue, 18 Feb 2025 14:00:44 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47203838881sm10061561cf.72.2025.02.18.14.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:00:43 -0800 (PST)
Date: Tue, 18 Feb 2025 17:00:41 -0500
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 0/4] igb: XDP/ZC follow up
Message-ID: <Z7UDCSckkK7J30oP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <Z7T5G9ZQRBb4EtdG@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7T5G9ZQRBb4EtdG@LQ3V64L9R2>

On Tue, Feb 18, 2025 at 04:18:19PM -0500, Joe Damato wrote:
> On Mon, Feb 17, 2025 at 12:31:20PM +0100, Kurt Kanzenbach wrote:
> > This is a follow up for the igb XDP/ZC implementation. The first two 
> > patches link the IRQs and queues to NAPI instances. This is required to 
> > bring back the XDP/ZC busy polling support. The last patch removes 
> > undesired IRQs (injected via igb watchdog) while busy polling with 
> > napi_defer_hard_irqs and gro_flush_timeout set.
> > 
> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> > ---
> > Changes in v2:
> > - Take RTNL lock in PCI error handlers (Joe)
> > - Fix typo in commit message (Gerhard)
> > - Use netif_napi_add_config() (Joe)
> > - Link to v1: https://lore.kernel.org/r/20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de
> 
> Thanks for sending a v2.
> 
> My comment from the previous series still stands, which simply that
> I have no idea if the maintainers will accept changes using this API
> or prefer to wait until Stanislav's work [1] is completed to remove
> the RTNL requirement from this API altogether.

Also, may be worth running the newly added XSK test with the NETIF
env var set to the igb device? Assuming eth0 is your igb device:

  NETIF=eth0 ./tools/testing/selftests/drivers/net/queues.py

should output:

  KTAP version 1
  1..4
  ok 1 queues.get_queues
  ok 2 queues.addremove_queues
  ok 3 queues.check_down
  ok 4 queues.check_xdp
  # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Note the check_xdp line above.

