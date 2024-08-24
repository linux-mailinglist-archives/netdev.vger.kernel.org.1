Return-Path: <netdev+bounces-121619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A8395DBE8
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 07:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BD61F21576
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 05:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C71714D0;
	Sat, 24 Aug 2024 05:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SXEbpwpH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F51714C8;
	Sat, 24 Aug 2024 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476719; cv=none; b=N09GlILQ8gTUQeW0JrIIaNfOF0jNot+Ka7bW8g1BAbJNLj8B9qMfrnRNj9O19P4L1IecpwhEwUZLHBSqC6N6up2zqocDOqnYko5e9cy/KKYeJ0867aFUpD1YHg35apz7vJ/3tzqIAvT/0cfgbGzUE7OjUZ+fiI4CXKnN8hK4qeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476719; c=relaxed/simple;
	bh=A86GmKBdFIJ2osp8JS9casQOmwY8tO+gEpbE1F7UnWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htRF0tfyi5yNLEGwmsoyZOFucrvWso8lXy0l7ezdBmFXR/MVZaIngxRiCEpF6v/H3jRLIkaJg2XjjSqmS6u3k7Hi/N0cu/ppm6c7+H4i1pPETXr8+IvsYkqJ9gLznsOFVWTHJMYfcv50akC//JkAUz0zy3nMwbjHTLyNkgWPSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SXEbpwpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C53C32781;
	Sat, 24 Aug 2024 05:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476718;
	bh=A86GmKBdFIJ2osp8JS9casQOmwY8tO+gEpbE1F7UnWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SXEbpwpHLF1UnDvKOEGQVJmfbA6FgOzdqnyQD8cbH546wQ+Bg1O3yLjnsbBsWqJrg
	 vnV8Ws/g2/z++BD11JKoyz2gnWhq6mi9TkLL+KW+vhGiLGswE3AEsIK23yG9fsDkka
	 eHQqu2uz18SGiKQhVxTIFwuMCDTh+Xx5Q6sOrM0g=
Date: Sat, 24 Aug 2024 11:29:10 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Timur Tabi <timur@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 2/4] cxl/region: Prevent device_find_child() from
 modifying caller's match data
Message-ID: <2024082420-vantage-thesaurus-99f2@gregkh>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com>
 <66c4a136d9764_2ddc2429435@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66c4a136d9764_2ddc2429435@iweiny-mobl.notmuch>

On Tue, Aug 20, 2024 at 08:59:18AM -0500, Ira Weiny wrote:
> Zijun Hu wrote:
> > From: Zijun Hu <quic_zijuhu@quicinc.com>
> > 
> > To prepare for constifying the following old driver core API:
> > 
> > struct device *device_find_child(struct device *dev, void *data,
> > 		int (*match)(struct device *dev, void *data));
> > to new:
> > struct device *device_find_child(struct device *dev, const void *data,
> > 		int (*match)(struct device *dev, const void *data));
> > 
> > The new API does not allow its match function (*match)() to modify
> > caller's match data @*data, but match_free_decoder() as the old API's
> > match function indeed modifies relevant match data, so it is not
> > suitable for the new API any more, fixed by implementing a equivalent
> > cxl_device_find_child() instead of the old API usage.
> 
> Generally it seems ok but I think some name changes will make this more
> clear.  See below.
> 
> Also for those working on CXL I'm questioning the use of ID here and the
> dependence on the id's being added to the parent in order.  Is that a
> guarantee?
> 
> > 
> > Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> > ---
> >  drivers/cxl/core/region.c | 36 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 35 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 21ad5f242875..8d8f0637f7ac 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -134,6 +134,39 @@ static const struct attribute_group *get_cxl_region_access1_group(void)
> >  	return &cxl_region_access1_coordinate_group;
> >  }
> >  
> > +struct cxl_dfc_data {
> 
> struct cxld_match_data
> 
> 'cxld' == cxl decoder in our world.
> 
> > +	int (*match)(struct device *dev, void *data);
> > +	void *data;
> > +	struct device *target_device;
> > +};
> > +
> > +static int cxl_dfc_match_modify(struct device *dev, void *data)
> 
> Why not just put this logic into match_free_decoder?
> 
> > +{
> > +	struct cxl_dfc_data *dfc_data = data;
> > +	int res;
> > +
> > +	res = dfc_data->match(dev, dfc_data->data);
> > +	if (res && get_device(dev)) {
> > +		dfc_data->target_device = dev;
> > +		return res;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * I have the same function as device_find_child() but allow to modify
> > + * caller's match data @*data.
> > + */
> 
> No need for this comment after the new API is established.
> 
> > +static struct device *cxl_device_find_child(struct device *parent, void *data,
> > +					    int (*match)(struct device *dev, void *data))
> > +{
> > +	struct cxl_dfc_data dfc_data = {match, data, NULL};
> > +
> > +	device_for_each_child(parent, &dfc_data, cxl_dfc_match_modify);
> > +	return dfc_data.target_device;
> > +}
> > +
> >  static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
> >  			 char *buf)
> >  {
> > @@ -849,7 +882,8 @@ cxl_region_find_decoder(struct cxl_port *port,
> >  		dev = device_find_child(&port->dev, &cxlr->params,
> >  					match_auto_decoder);
> >  	else
> > -		dev = device_find_child(&port->dev, &id, match_free_decoder);
> > +		dev = cxl_device_find_child(&port->dev, &id,
> > +					    match_free_decoder);
> 
> This is too literal.  How about the following (passes basic cxl-tests).
> 
> Ira
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c              
> index 21ad5f242875..c1e46254efb8 100644                                         
> --- a/drivers/cxl/core/region.c                                                 
> +++ b/drivers/cxl/core/region.c                                                 
> @@ -794,10 +794,15 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>         return rc;                                                              
>  }                                                                              
>                                                                                 
> +struct cxld_match_data {                                                       
> +       int id;                                                                 
> +       struct device *target_device;                                           
> +};                                                                             
> +                                                                               
>  static int match_free_decoder(struct device *dev, void *data)                  
>  {                                                                              
> +       struct cxld_match_data *match_data = data;                              
>         struct cxl_decoder *cxld;                                               
> -       int *id = data;                                                         
>                                                                                 
>         if (!is_switch_decoder(dev))                                            
>                 return 0;                                                       
> @@ -805,17 +810,30 @@ static int match_free_decoder(struct device *dev, void *data)
>         cxld = to_cxl_decoder(dev);                                             
>                                                                                 
>         /* enforce ordered allocation */                                        
> -       if (cxld->id != *id)                                                    
> +       if (cxld->id != match_data->id)                                         
>                 return 0;                                                       
>                                                                                 
> -       if (!cxld->region)                                                      
> +       if (!cxld->region && get_device(dev)) {                                 
> +               match_data->target_device = dev;                                
>                 return 1;                                                       
> +       }                                                                       
>                                                                                 
> -       (*id)++;                                                                
> +       match_data->id++;                                                       
>                                                                                 
>         return 0;                                                               
>  }                                                                              
>                                                                                 
> +static struct device *find_free_decoder(struct device *parent)                 
> +{                                                                              
> +       struct cxld_match_data match_data = {                                   
> +               .id = 0,                                                        
> +               .target_device = NULL,                                          
> +       };                                                                      
> +                                                                               
> +       device_for_each_child(parent, &match_data, match_free_decoder);         
> +       return match_data.target_device;                                        
> +}                                                                              

I like this type of re-write much better, thanks!

greg k-h

